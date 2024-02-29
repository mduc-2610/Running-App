
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // in the below line, we are initializing our controller for google maps.  
  final Completer<GoogleMapController> _controller = Completer();

  // in the below line, we are specifying our camera position 
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(37.42796133580664, -122.885749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // in the below line, we are specifying our app bar. 
        appBar: AppBar(
          // setting background color for app bar
          backgroundColor: const Color(0xFF0F9D58),
          // setting title for app bar.
          title: const Text("Google Maps"),
        ),
        body: Container(
          // in the below line, creating google maps.
          child: GoogleMap(
            // in the below line, setting camera position
            initialCameraPosition: _kGoogle,
            // in the below line, specifying map type.
            mapType: MapType.normal,
            // in the below line, setting user location enabled.
            myLocationEnabled: true,
            // in the below line, setting compass enabled.
            compassEnabled: true,
            // in the below line, specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        )
    );
  }
}