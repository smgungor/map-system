import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/yellow.dart';

class Sorgu1 extends StatefulWidget {
  @override
  _Sorgu1State createState() => _Sorgu1State();
}

class _Sorgu1State extends State<Sorgu1> {
  final db = Firestore.instance;

  Future<List<Yellow>> kullanicilariGetir() async {
    QuerySnapshot snapshot = await db
        .collection("yellow-trip2")
        .orderBy("trip_distance", descending: true)
        .limit(5)
        .getDocuments();
    List<Yellow> kullanicilar = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    return kullanicilar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: Text("Sorgu1"),
      ),
      body: Container(
        color: Colors.green[100],
        child: FutureBuilder<List<Yellow>>(
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return Container(
              margin: EdgeInsets.only(top: 50.0),
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
                      title: Text(snapshot.data[pozisyon].trip_distance + " KM",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        Yellow.tarihGonder(
                            snapshot.data[pozisyon].tpep_pickup_datetime),
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          future: kullanicilariGetir(),
        ),
      ),
    );
  }
}
