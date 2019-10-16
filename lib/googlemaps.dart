import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/Provider/database.dart';
import 'package:mobile/model/locationModel.dart';

class GoogleMaps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  Map<String, Marker> markers = Map<String, Marker>();
  LocationData currentLocation;
  bool userMarkerInitiated = false;
  GoogleMapController mapController;

  Location location = Location();
  String error;

  Timer timer;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      databaseProvider.setCurrentUser(user);
    });

    timer = Timer.periodic(Duration(seconds: 3), (t) {
      databaseProvider.setUserLocation(
          UserLocation(currentLocation.latitude, currentLocation.longitude));
    });
    super.initState();

    initPlatformState();

    location.onLocationChanged().listen((LocationData result) {
      currentLocation = result;

      if (!userMarkerInitiated) {
        // markers.putIfAbsent(
        //   "myMarker",
        //   () => Marker(
        //     markerId: MarkerId('myMarker'),
        //     draggable: false,
        //     onTap: () {
        //       print("Marker Tapped");
        //     },
        //     position:
        //         LatLng(currentLocation.latitude, currentLocation.longitude),
        //   ),
        // );
        userMarkerInitiated = true;
      } else {
        // markers["myMarker"] = Marker(
        //   markerId: MarkerId('myMarker'),
        //   draggable: false,
        //   onTap: () {
        //     print("Marker Tapped");
        //   },
        //   position: LatLng(currentLocation.latitude, currentLocation.longitude),
        // );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: currentLocation == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    // myLocationEnabled: true,
                    trackCameraPosition: true,
                    compassEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      zoom: 15.0,
                    ),
                    onMapCreated: _onMapCreated,
                  ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FlatButton(
              child: Icon(
                Icons.pin_drop,
                size: 50,
                color: Colors.blue,
              ),
              // color: Colors.red,
              onPressed: () => _addMarker(),
            ),
          ),
        ],
      ),
    );
  }

  void initPlatformState() async {
    try {
      currentLocation = await location.getLocation();
      error = "";
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED')
        error = 'Permission Denied';
      else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error =
            'Permission Denied - please ask the user to enable it from app setting';
    }
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _addMarker() {
    var marker = MarkerOptions(
      position: mapController.cameraPosition.target,
      icon: BitmapDescriptor.defaultMarker,
      infoWindowText: InfoWindowText('My Location', '🍄🍄🍄'),
    );
    mapController.addMarker(marker);
  }
}
