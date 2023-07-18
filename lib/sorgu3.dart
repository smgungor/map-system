import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/yellow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Sorgu3 extends StatefulWidget {
  Timestamp a;
  Sorgu3(this.a);
  @override
  _Sorgu3State createState() => _Sorgu3State();
}

class _Sorgu3State extends State<Sorgu3> {
  GoogleMapController mapController;
  double _originLatitude = 40.730610, _originLongitude = -73.935242;
  double _destLatitude = 41.2303557, _destLongitude = 35.9683338;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "your_google_api_key_here";
  final db = Firestore.instance;
  final db2 = Firestore.instance;
  int pul;
  int dol;
  var pull;
  var doll;
  Future<List<Yellow>> kullanicilariGetir(Timestamp a) async {
    QuerySnapshot snapshot = await db
        .collection("yellow-trip2")
        .where("tpep_pickup_datetime",
            isEqualTo: (a.millisecondsSinceEpoch / 1000))
        .orderBy("trip_distance", descending: true)
        .limit(1)
        .getDocuments();
    List<Yellow> kullanicilar = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    print("********************");
    print(a.millisecondsSinceEpoch / 1000);
    pul = int.parse(kullanicilar[0].pulocationID);
    dol = int.parse(kullanicilar[0].dolactionID);
    pull = await locIdGetir(pul);
    doll = await locIdGetir(dol);
    _originLatitude = pull[0];
    _originLongitude = pull[1];
    _destLatitude = doll[0];
    _destLongitude = doll[1];
    print(pull[0].toString());
    _islem();
    return kullanicilar;
  }

  locIdGetir(int defLoc) async {
    QuerySnapshot snapshot = await db2
        .collection("taxi-zonel")
        .where("LocationID", isEqualTo: defLoc)
        .limit(1)
        .getDocuments();
    List<Yellow> loc = snapshot.documents.map((doc) {
      return Yellow.dokumandanUret(doc);
    }).toList();
    return [loc[0].latitude, loc[0].longitude];
  }

  _islem() {
    _addMarker(
        LatLng(pull[0], pull[1]), "origin", BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(doll[0], doll[1]), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  void initState() {
    super.initState();
    kullanicilariGetir(widget.a);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[100],
            title: Text("Google Maps"),
          ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 8),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBlPZtfDLqvVBMN3H-6QzqJpKYM-MUgc28",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      print("sonucc:");
      print(result);
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
