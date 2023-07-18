import 'package:fireworks/locations.dart';
import 'package:fireworks/sorgu2goster.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sorgu2 extends StatefulWidget {
  @override
  _Sorgu2State createState() => _Sorgu2State();
}

class _Sorgu2State extends State<Sorgu2> {
  DateTime selectedDate = DateTime.fromMillisecondsSinceEpoch(1606780800000);
  DateTime selectedDate2 = DateTime.fromMillisecondsSinceEpoch(1609372800000);
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          title: Text(""),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  'Select date',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                color: Colors.greenAccent,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.yellow[300]),
                child: DropdownButton<String>(
                  value: defaultLoc,
                  elevation: 3,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
                          builder: (BuildContext context) =>
                              Sorgu2goster(a, b, defaultLoc)));
                },
                child: Text(
                  'Enter',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.red,
              )
            ],
          ),
        ));
  }
}
