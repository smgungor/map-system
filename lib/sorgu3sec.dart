import 'package:fireworks/locations.dart';
import 'package:fireworks/sorgu3.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sorgu3sec extends StatefulWidget {
  @override
  _Sorgu3secState createState() => _Sorgu3secState();
}

class _Sorgu3secState extends State<Sorgu3sec> {
  DateTime selectedDate = DateTime.fromMillisecondsSinceEpoch(1606780800000);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[100],
          title: Text(""),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 180.0,
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
                height: 80.0,
              ),
              RaisedButton(
                onPressed: () {
                  Timestamp a = Timestamp.fromDate(selectedDate);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Sorgu3(a)));
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
