import 'package:fireworks/sorgu1.dart';
import 'package:fireworks/sorgu2.dart';
import 'package:fireworks/sorgu3sec.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: GirisSayfasi(),
    );
  }
}

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 55.0,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/map-525349_1280.png"),
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Sorgu1()));
              },
              child: Text(
                "Mobil Sorgulama",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 7.0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Sorgu1()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Sorgu1",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            width: double.infinity,
                            height: 52.0,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20.0)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Sorgu2()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Sorgu2",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              height: 52.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Sorgu3sec()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Sorgu3",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              height: 52.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 227, 66, 100),
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple[300], Colors.purple[100]])),
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width - 70,
                height: 180.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*class Sorgu1 extends StatefulWidget {
  @override
  _Sorgu1State createState() => _Sorgu1State();
}

class _Sorgu1State extends State<Sorgu1> {
  final db = Firestore.instance;

  Future<List<Yellow>> kullanicilariGetir() async {
    QuerySnapshot snapshot = await db
        .collection("yellow-trip")
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
      body: FutureBuilder<List<Yellow>>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, pozisyon) {
              return ListTile(
                title: Text(snapshot.data[pozisyon].trip_distance),
                subtitle: Text(Yellow.tarihGonder(
                    snapshot.data[pozisyon].tpep_pickup_datetime)),
              );
            },
          );
        },
        future: kullanicilariGetir(),
      ),
    );
  }
}*/

/*class Sorgu2 extends StatefulWidget {
  @override
  _Sorgu2State createState() => _Sorgu2State();
}

class _Sorgu2State extends State<Sorgu2> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  String defaultLoc = "Newark Airport";
  Locations location = Locations();
  final db = Firestore.instance;
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "${selectedDate.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            'Select date',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 100,
          width: double.infinity,
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value: defaultLoc,
            elevation: 3,
            style: TextStyle(color: Colors.red[200], fontSize: 14),
            underline: Container(
              height: 2,
              color: Colors.red[200],
            ),
            onChanged: (String deger) {
              setState(() {
                defaultLoc = deger;
              });
            },
            items: location.locations
                .map<DropdownMenuItem<String>>((String deger) {
              return DropdownMenuItem<String>(
                value: deger,
                child: Text(deger),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Text(
          "${selectedDate2.toLocal()}".split(' ')[0],
          style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => _selectDate2(context),
          child: Text(
            'Select date',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          color: Colors.greenAccent,
        ),
        SizedBox(
          height: 50.0,
        ),
        RaisedButton(
          onPressed: () {
            Timestamp a = Timestamp.fromDate(selectedDate);
            Timestamp b = Timestamp.fromDate(selectedDate2);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Sorgu2goster(a, b)));
          },
          child: Text(
            'Enter',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          color: Colors.red,
        )
      ],
    );
  }
}*/

/*class Sorgu2goster extends StatefulWidget {
  Timestamp a;
  Timestamp b;
  Sorgu2goster(this.a, this.b);
  @override
  _Sorgu2gosterState createState() => _Sorgu2gosterState();
}

class _Sorgu2gosterState extends State<Sorgu2goster> {
  final db = Firestore.instance;
  Future<List<Yellow>> kullanicilariGetir(Timestamp a, Timestamp b) async {
    QuerySnapshot snapshot = await db
        .collection("yellow-trip")
        .where("tpep_pickup_datetime",
            isLessThan: b.millisecondsSinceEpoch / 1000)
        .where("tpep_pickup_datetime",
            isGreaterThan: a.millisecondsSinceEpoch / 1000)
        .where("PULocationID", isEqualTo: "246")
        .getDocuments();
    List<Yellow> kullanicilar = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    print(kullanicilar);
    return kullanicilar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Yellow>>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, pozisyon) {
              return ListTile(
                title: Text(snapshot.data.length.toString()),
                subtitle: Text(Yellow.tarihGonder(
                    snapshot.data[pozisyon].tpep_pickup_datetime)),
              );
            },
          );
        },
        future: kullanicilariGetir(widget.a, widget.b),
      ),
    );
  }
}*/

/*class Sorgu3 extends StatefulWidget {
  @override
  _Sorgu3State createState() => _Sorgu3State();
}

class _Sorgu3State extends State<Sorgu3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Sorgu3"),
    ));
  }
}*/
