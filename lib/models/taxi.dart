import 'package:cloud_firestore/cloud_firestore.dart';

class Taxi {
  final String borough;
  final int locationID;

  Taxi({this.borough, this.locationID});

  factory Taxi.dokumandanUret(DocumentSnapshot doc) {
    return Taxi(
      borough: doc.data["Borough"].toString(),
      locationID: doc.data["LocationID"],
    );
  }
}
