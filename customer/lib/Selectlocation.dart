import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  String phone;
  MapSample({this.phone});
  @override
  State<MapSample> createState() => MapSampleState(this.phone);
}

final Firestore _db = Firestore.instance;
var cartref;

class MapSampleState extends State<MapSample> {
  String phone;
  MapSampleState(this.phone);
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  LatLng point;
  List<Marker> markerlist = [];
  @override
  initstuff() async {}

  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: _scaffoldKey,
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: Set.from(markerlist),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (tappedpoint) {
          setState(() {
            markerlist.clear();
            point = tappedpoint;
            markerlist.add(Marker(
                markerId: MarkerId(tappedpoint.toString()),
                position: tappedpoint));
            print(tappedpoint.runtimeType);
            print(tappedpoint);
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _db.collection("orders").document("TwOkyT9buM1d4D08sROL").updateData({
            'location': GeoPoint(point.latitude, point.longitude),
            'locationprovided': true
          });
          final snackBar = await SnackBar(content: Text('Done'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
          // sleep(Duration(seconds: 2));
          Navigator.pop(context);
        },
        label: Text('Select pins'),
        icon: Icon(Icons.directions),
      ),
    );
  }
}
