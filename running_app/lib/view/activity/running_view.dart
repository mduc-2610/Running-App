import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app/models/activity/entry.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:live___cpLocation_tracking/entry.dart';

// class OrderTrackingPage extends StatefulWidget {
//   const OrderTrackingPage({Key? key}) : super(key: key);
//   @override
//   State<OrderTrackingPage> createState() => OrderTrackingPageState();
// }
// class OrderTrackingPageState extends State<OrderTrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   static const LatLng destination = LatLng(37.33429383, -122.06600055);
//
//   List<LatLng> polylineCoordinates = [];
//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyCyKliDy1wrn2TjgCG_En1QJSU5G4vOXg4", // Your Google Map Key
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//             (PointLatLng point) => polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         ),
//       );
//       setState(() {});
//     }
//   }
//
//   // LocationData? currentLocation;
//   // void getCurrentLocation() async {
//   //   Location __cpLocation = Location();
//   //   __cpLocation.getLocation().then(
//   //         (__cpLocation) {
//   //       currentLocation = __cpLocation;
//   //     },
//   //   );
//   //   GoogleMapController googleMapController = await _controller.future;
//   //   __cpLocation.onLocationChanged.listen(
//   //         (newLoc) {
//   //       currentLocation = newLoc;
//   //       googleMapController.animateCamera(
//   //         CameraUpdate.newCameraPosition(
//   //           CameraPosition(
//   //             zoom: 13.5,
//   //             target: LatLng(
//   //               newLoc.latitude!,
//   //               newLoc.longitude!,
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //       setState(() {});
//   //     },
//   //   );
//   // }
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//   void setCustomMarkerIcon() {
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, "assets/Pin_source.png")
//         .then(
//           (icon) {
//         sourceIcon = icon;
//       },
//     );
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, "assets/Pin_destination.png")
//         .then(
//           (icon) {
//         destinationIcon = icon;
//       },
//     );
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, "assets/Badge.png")
//         .then(
//           (icon) {
//         currentLocationIcon = icon;
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     getPolyPoints();
//     // getCurrentLocation();
//     setCustomMarkerIcon();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: sourceLocation == null
//           ? const Center(child: Text("Loading"))
//           : GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//               sourceLocation!.latitude!, sourceLocation!.longitude!),
//           zoom: 13.5,
//         ),
//         markers: {
//           // Marker(
//           //   markerId: const MarkerId("currentLocation"),
//           //   icon: currentLocationIcon,
//           //   position: LatLng(
//           //       currentLocation!.latitude!, currentLocation!.longitude!),
//           // ),
//           Marker(
//             markerId: const MarkerId("source"),
//             icon: sourceIcon,
//             position: sourceLocation,
//           ),
//           Marker(
//             markerId: MarkerId("destination"),
//             icon: destinationIcon,
//             position: destination,
//           ),
//         },
//         onMapCreated: (mapController) {
//           _controller.complete(mapController);
//         },
//         polylines: {
//           Polyline(
//             polylineId: const PolylineId("route"),
//             points: polylineCoordinates,
//             color: const Color(0xFF7B61FF),
//             width: 6,
//           ),
//         },
//       ),
//     );
//   }
// }

// class OrderTrackingPage extends StatefulWidget {
//   const OrderTrackingPage({Key? key}) : super(key: key);
//   @override
//   State<OrderTrackingPage> createState() => OrderTrackingPageState();
// }
// class OrderTrackingPageState extends State<OrderTrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   static const LatLng destination = LatLng(37.33429383, -122.06600055);
//
//   // List<LatLng> polylineCoordinates = [];
//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       google_api_key, // Your Google Map Key
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//             (PointLatLng point) => polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         ),
//       );
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: sourceLocation,
//           zoom: 13.5,
//         ),
//         markers: {
//           const Marker(
//             markerId: MarkerId("source"),
//             position: sourceLocation,
//           ),
//           const Marker(
//             markerId: MarkerId("destination"),
//             position: destination,
//           ),
//         },
//         onMapCreated: (mapController) {
//           _controller.complete(mapController);
//         },
//       ),
//     );
//   }
// }

class EntryCard extends StatelessWidget {
  final Entry entry;
  const EntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.date!, style: const TextStyle(fontSize: 18)),
                  Text("${(entry.distance! / 1000).toStringAsFixed(2)} km",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.duration!,
                      style: const TextStyle(fontSize: 14)),
                  Text("${entry.speed!.toStringAsFixed(2)} km/h",
                      style: const TextStyle(fontSize: 14)),
                ],
              )
            ],
          )),
    );
  }
}

class MapStats extends StatefulWidget {
  const MapStats({super.key});

  @override
  State<MapStats> createState() => _MapStatsState();
}

class _MapStatsState extends State<MapStats> {
  late List<Entry> _data;
  List<EntryCard> _cards = [];
  late DB db;
  @override
  void initState() {
    db = DB();
    WidgetsBinding.instance.addPostFrameCallback((_){
      db.init().then((value) => _fetchEntries());
    });
    super.initState();
  }

  void _fetchEntries() async {
    _cards = [];

    try{
      List<Map<String, dynamic>> results = await db.query(Entry.table);
      _data = results.map((item) => Entry.fromMap(item)).toList();
      for (var element in _data) {
        _cards.add(EntryCard(entry: element));
      }
      setState(() {});
    }catch (e){
      print(e.toString());
    }
  }

  void _addEntries(Entry en) async {
    db.insert(Entry.table, en);
    _fetchEntries();
  }
  Future<Position?> getPermission() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    Position? position = await Geolocator.getLastKnownPosition();{
      if(position != null){
        return position;
      }else{
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
    }

  }

// Alert dialog opening when getPermission() return null
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please Open Your Location'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children:[
              const SizedBox(height: 20,),
              SizedBox(child: FloatingActionButton(
                onPressed: () async {
                  Position? pos = await getPermission();
                  if (pos != null) {
// When pop page in MapPage _addEntries(value) method works and
// saving records to db and showing in MapStatsPage
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const MapPage()))
                        .then((value) => _addEntries(value));
                  }else{
                    showMyDialog();
                  }
                } ,
                backgroundColor:Theme.of(context).primaryColor,
                child: const Icon(Icons.add,size: 32,),
              ),),
              const SizedBox(height: 20,),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding:  const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_cards[index].entry.date.toString(),style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                    Text("Duration : ${_cards[index].entry.duration}",style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600)),
                                  ],),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Distance (Km) : ${(_cards[index].entry.distance! / 1000).toStringAsFixed(2)}",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600)),
                                    Text("Speed (Km/Hours) : ${_cards[index].entry.speed!.toStringAsFixed(2)}",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600)),
                                  ],)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ]
        ),
      ),
    );
  }
}


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Polyline> polyline = {};
  final List<LatLng> polylineCoordinates = [];
  List<LatLng> route = [];
  double dist = 0;
  late String displayTime;
  late int time;
  late int lastTime;
  double speed = 0;
  double avgSpeed = 0;
  int speedCounter = 0;
  late bool loadingStatus;
  late double appendDist;
  LatLng sourceLocation = const LatLng(37.33500926, -122.03272188);
  LatLng destination = const LatLng(37.33429383, -122.06600055);

  Position? currentPosition;
  final Completer<GoogleMapController?> controller = Completer();
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  var mapStyle;
  late StreamSubscription<Position> positionStream;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCyKliDy1wrn2TjgCG_En1QJSU5G4vOXg4", // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }
  @override
  void initState() {
    getPolyPoints();
    route.clear();
    polyline.clear();
    dist = 0;
    time = 0;
    lastTime = 0;
    speed = 0;
    avgSpeed = 0;
    speedCounter = 0;
    appendDist = 0;
    // stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    stopWatchTimer.clearPresetTime();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentPosition();
    });
    // stopWatchTimer.onExecute.add(StopWatchExecute.start);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    stopWatchTimer.dispose();
  }

  Future<void> getCurrentPosition() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
    if (currentPosition != null) {
      late LocationSettings cpLocationSettings;
      cpLocationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 5);

      positionStream =
          Geolocator.getPositionStream(locationSettings: cpLocationSettings)
              .listen((Position? position) async {
            print(position == null
                ? 'Unknown'
                : '${position.latitude.toString()}, ${position.longitude.toString()}');
            currentPosition = position;

            if (route.isNotEmpty) {
              appendDist = Geolocator.distanceBetween(route.last.latitude,
                  route.last.longitude, position!.latitude, position.longitude);
              dist = dist + appendDist;
              int timeDuration = (time - lastTime);

              if (timeDuration != 0) {
                speed = (appendDist / (timeDuration / 100)) * 3.6;
                if (speed != 0) {
                  avgSpeed = avgSpeed + speed;
                  speedCounter++;
                }
              }
            }
            lastTime = time;

            if (route.isNotEmpty) {
              if (route.last != LatLng(position!.latitude, position.longitude)) {
                route.add(LatLng(position.latitude, position.longitude));

                polyline.add(Polyline(
                    polylineId: PolylineId(position.toString()),
                    visible: true,
                    points: route,
                    width: 6,
                    startCap: Cap.roundCap,
                    endCap: Cap.roundCap,
                    color: Colors.blue));
              }
            } else {
              route.add(LatLng(position!.latitude, position.longitude));
            }

            setState(() {});
          });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPosition == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Stack(children: [
          GoogleMap(
            markers: {
              Marker(
                markerId: const MarkerId("source"),
                position: sourceLocation,
              ),
              Marker(
                markerId: const MarkerId("destination"),
                position: destination
              )
            },
            // polylines: polyline,
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCoordinates,
                color: const Color(0xFF7B61FF),
                width: 6,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(sourceLocation.latitude,
                    sourceLocation.longitude),
                zoom: 13.5),
            onMapCreated: (mapController) {
              mapController.setMapStyle(mapStyle);
              if (controller.isCompleted) {
                controller.complete(mapController);
                setState(() {});
              }
              setState(() {});
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                height: 125,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Speed (Km/Hours)",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              speed.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Duration",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            StreamBuilder<int>(
                              stream: stopWatchTimer.rawTime,
                              initialData: 0,
                              builder: (context, snap) {
                                time = snap.data!;
                                displayTime =
                                "${StopWatchTimer.getDisplayTimeHours(time)}:${StopWatchTimer.getDisplayTimeMinute(time)}:${StopWatchTimer.getDisplayTimeSecond(time)}";
                                return Text(
                                  displayTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300),
                                );
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Distance (Km)",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              (dist / 1000).toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      child: const Icon(
                        Icons.stop_circle_outlined,
                        size: 45,
                        color: Colors.redAccent,
                      ),
                      onTap: () async {
                        Entry en = Entry(
                            date: DateFormat.yMMMMd()
                                .format(DateTime.now()),
                            duration: displayTime,
                            speed: speedCounter == 0
                                ? 0
                                : avgSpeed / speedCounter,
                            distance: dist);
                        //  positionStream.cancel();
                        Navigator.pop(context, en);
                      },
                    ),
                  ],
                ),
              ))
        ]));
  }
}