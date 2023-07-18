import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Yellow {
  final String trip_distance;
  final int tpep_pickup_datetime;
  final String borough;
  final int locationID;
  final String pulocationID;
  final String dolactionID;
  final double latitude;
  final double longitude;
  Yellow(
      {this.trip_distance,
      this.tpep_pickup_datetime,
      this.borough,
      this.locationID,
      this.pulocationID,
      this.dolactionID,
      this.latitude,
      this.longitude});

  static String tarihGonder(var timeInMillis) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis * 1000);
    var formattedDate = DateFormat.yMMMMEEEEd().format(date).toString();
    return formattedDate;
  }

  factory Yellow.dokumandanUret(DocumentSnapshot doc) {
    return Yellow(
        trip_distance: doc.data["trip_distance"].toString(),
        tpep_pickup_datetime: doc.data["tpep_pickup_datetime"],
        borough: doc.data["Borough"].toString(),
        locationID: doc.data["LocationID"],
        pulocationID: doc.data["PULocationID"].toString(),
        dolactionID: doc.data["DOLocationID"].toString(),
        latitude: doc.data["latitude"],
        longitude: doc.data["longitude"]);
  }
}
