import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  String phone;
  MapSample({this.phone});
  @override
  State<MapSample> createState() => MapSampleState(this.phone);
}

final Firestore _db = Firestore.instance;

class MapSampleState extends State<MapSample> {
  String phone;
  MapSampleState(this.phone);
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng point;
  List<Marker> markerlist = [];
  List<DocumentSnapshot> posts;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchorders();
  }

  _fetchorders() async {
    try {
      QuerySnapshot snap = await _db
          .collection("orders")
          .where("productid", isEqualTo: phone)
          .getDocuments();
      setState(() {
        posts = snap.documents;
        print(posts[0].data["location"]);
        GeoPoint temp = posts[0].data["location"];
        print(temp.latitude.toString() + "dfdf");
        _kGooglePlex = CameraPosition(
          target: LatLng(temp.latitude, temp.longitude),
          zoom: 14.4746,
        );

        markerlist.add(Marker(
            markerId: MarkerId("location"),
            position: LatLng(temp.latitude, temp.longitude)));
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : new Scaffold(
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
          );
  }
}
