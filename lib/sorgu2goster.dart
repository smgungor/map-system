import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/yellow.dart';

class Sorgu2goster extends StatefulWidget {
  Timestamp a;
  Timestamp b;
  String defLoc;
  Sorgu2goster(this.a, this.b, this.defLoc);
  @override
  _Sorgu2gosterState createState() => _Sorgu2gosterState();
}

class _Sorgu2gosterState extends State<Sorgu2goster> {
  final db = Firestore.instance;
  final db2 = Firestore.instance;
  static int locId = 0;
  static int aracSayisi = 0;
  Future<List<Yellow>> kullanicilariGetir(
      Timestamp a, Timestamp b, String defLoc) async {
    locIdGetir(defLoc);
    await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await db
        .collection("yellow-trip2")
        .where("tpep_pickup_datetime",
            isLessThanOrEqualTo: b.millisecondsSinceEpoch / 1000)
        .where("tpep_pickup_datetime",
            isGreaterThanOrEqualTo: a.millisecondsSinceEpoch / 1000)
        .where("PULocationID", isEqualTo: locId.toString())
        .getDocuments();
    List<Yellow> kullanicilar = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    await Future.delayed(Duration(seconds: 2));

    return kullanicilar;
  }

  Future<List<Yellow>> locIdGetir(String defLoc) async {
    QuerySnapshot snapshot = await db2
        .collection("taxi-zone")
        .where("Zone", isEqualTo: defLoc)
        .limit(1)
        .getDocuments();
    List<Yellow> loc = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    locId = loc[0].locationID;
    return loc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text(""),
      ),
      body: Container(
        color: Colors.blue[100],
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: FutureBuilder<List<Yellow>>(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    return Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, pozisyon) {
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.purple[100]),
                            child: ListTile(
                              leading: Text(
                                (pozisyon + 1).toString(),
                                style: TextStyle(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[200]),
                              ),
                              title: Text(
                                  snapshot.data[pozisyon].trip_distance +
                                      " KM"),
                              subtitle: Text(Yellow.tarihGonder(snapshot
                                  .data[pozisyon].tpep_pickup_datetime)),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  future:
                      kullanicilariGetir(widget.a, widget.b, widget.defLoc)),
            ),
          ],
        ),
      ),
    );
  }
}
