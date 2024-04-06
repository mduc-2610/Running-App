import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:running_app/utils/common_widgets/app_bar.dart';
import 'package:running_app/utils/common_widgets/header.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_month_year.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/common_widgets/wrapper.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActivityRecordView extends StatefulWidget {
  const ActivityRecordView({super.key});

  @override
  _ActivityRecordViewState createState() => _ActivityRecordViewState();
}

class _ActivityRecordViewState extends State<ActivityRecordView> {
  IconData _showCalculateButtonState = Icons.arrow_forward_ios_rounded;
  GoogleMapController? _controller;
  final loc.Location _location = loc.Location();
  final Set<Marker> _markers = {};
  Polyline _polyline = const Polyline(polylineId: PolylineId("poly"));

  IconData playButtonState = Icons.play_arrow_rounded;
  bool firstTime = true;
  LatLng _sourceLocation = const LatLng(21.0245, 105.84117);
  LatLng _currentLocation = const LatLng(21.0245, 105.84117);

  Timer? _timer;
  double _distance = 0.0;
  int _timeInSeconds = 0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _getLocation() async {
    loc.LocationData locationData = await _location.getLocation();
    setState(() {
      // _sourceLocation = ;
      // _currentLocation = _sourceLocation;
      _markers.add(Marker(markerId: const MarkerId("source"), position: _currentLocation));
      _controller?.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation, 20));
    });
  }
  final double minRadius = 0.00002;
  final double maxRadius = 0.000065;
  final Random random = Random();

  double getRandomRadius() {
    return minRadius + random.nextDouble() * (maxRadius - minRadius);
  }
  void _generateRandomPosition() {
    final double radius = getRandomRadius();
    // final double radius = 0.000065;
    final random = Random();
    double firstRandom = random.nextDouble();
    double secondRandom =  random.nextDouble();
    if(secondRandom < 0 && firstRandom > 0) secondRandom *= -1;
    double lat = _currentLocation.latitude + (firstRandom * 2 - 1) * radius;
    double lng = _currentLocation.longitude + (secondRandom * 2 - 1) * radius;

    LatLng newPosition = LatLng(lat, lng);
    Set<LatLng> newPolylinePoints = _polyline.points.toSet();
    newPolylinePoints.add(newPosition);

    setState(() {
      _currentLocation = newPosition;
      _markers.add(Marker(markerId: const MarkerId("destination"), position: _currentLocation));
      _polyline = Polyline(
        polylineId: const PolylineId("poly"),
        points: newPolylinePoints.toList(),
        color: Colors.blue,
        width: 5,
      );
      _distance += _calculateDistance(_sourceLocation, _currentLocation);
      _sourceLocation = _currentLocation;
    });
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const int earthRadius = 6371000;
    double latDiff = _degreesToRadians(to.latitude - from.latitude);
    double lngDiff = _degreesToRadians(to.longitude - from.longitude);
    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(_degreesToRadians(from.latitude)) *
            cos(_degreesToRadians(to.latitude)) *
            sin(lngDiff / 2) *
            sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _startTracking() {
    if(playButtonState == Icons.play_arrow_rounded) {
      const int updateInterval = 1; // in seconds
      _timer = Timer.periodic(const Duration(seconds: updateInterval), (timer) {
        setState(() {
          _timeInSeconds += updateInterval;
        });
        _generateRandomPosition();
      });
    } else {
      _timer?.cancel();
    }
    setState(() {
      firstTime = false;
      playButtonState = (playButtonState == Icons.play_arrow_rounded)
          ? Icons.pause
          : Icons.play_arrow_rounded;
    });
  }

  void _stopTracking() async {
    _timer?.cancel();
    await _controller!.animateCamera(CameraUpdate.zoomTo(18)); // Set zoom level to 15

    final imageBytes = await _controller!.takeSnapshot();
    Navigator.pushNamed(context, '/activity_record_create', arguments: {
      "totalDistance": _distance,
      "totalTime": _timeInSeconds,
      "pace": paceRepresentation(_timeInSeconds, _distance),
      "mapImage": imageBytes,
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Header(
            title: "Activity Record",
            noIcon: true,
            backButton: (playButtonState == Icons.play_arrow_rounded) ? true : false,
            backButtonOnPressed: () {
              if(firstTime == false) {
                showActionList(context, [
                  {
                    "text": "Yes",
                    "onPressed": () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  },
                  {
                    "text": "No",
                    "onPressed": () {
                      Navigator.pop(context);
                    },
                    "textColor": TColor.WARNING,
                  }
                ], "Are you sure to delete this activity?");
                showModalBottomSheet(context: context, builder: (context) => Container(),);
              }
            },
        ),
        backgroundImage: TImage.PRIMARY_BACKGROUND_IMAGE,
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: _markers,
            polylines: {_polyline},
            initialCameraPosition: CameraPosition(
              target: _sourceLocation,
              zoom: 18,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          if(firstTime == false)...[
            Wrapper(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    if(_showCalculateButtonState == Icons.arrow_forward_ios_rounded)...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for(var x in [
                              {
                                "figure": (_distance / 1000).toStringAsFixed(2),
                                // "figure":  "1",
                                "type": "Distance (km)"
                              },
                              {
                                "figure": durationRepresentation(_timeInSeconds),
                                "type": "Total time",
                              }
                            ])...[
                              SizedBox(
                                width: media.width * 0.45,
                                child: Column(
                                  children: [
                                    Text(
                                      x["figure"] as String,
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      x["type"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if(x["type"] == "Distance (km)") SeparateBar(width: 2, height: media.width * 0.1, color: TColor.BORDER_COLOR,)
                            ]
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for(var x in [
                              {
                                "figure": paceRepresentation(_timeInSeconds, _distance),
                                "type": "Current Pace (/km)"
                              },
                              {
                                "figure": paceRepresentation(_timeInSeconds, _distance),
                                "type": "Avg. Pace (/km)",
                              }
                            ])...[
                              SizedBox(
                                width: media.width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      x["figure"] as String,
                                      style: TextStyle(
                                        color: TColor.PRIMARY_TEXT,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      x["type"] as String,
                                      style: TextStyle(
                                        color: TColor.DESCRIPTION,
                                        fontSize: FontSize.SMALL,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if(x["type"] == "Current Pace (/km)") SeparateBar(width: 2, height: media.width * 0.1, color: TColor.BORDER_COLOR,)
                            ]
                          ],
                        ),
                      ),
                    ],
                    SizedBox(
                      width: media.width,
                      height: 35,
                      child: CustomTextButton(
                        onPressed: () {
                          setState(() {
                            _showCalculateButtonState = (_showCalculateButtonState == Icons.arrow_forward_ios_rounded)
                                ? Icons.arrow_back_ios_rounded
                                : Icons.arrow_forward_ios_rounded;
                          });
                        },
                        child: Transform.rotate(
                          angle: -90 * 3.14159 / 180,
                          child: Icon(
                            _showCalculateButtonState,
                            color: TColor.PRIMARY_TEXT,
                          ),
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(firstTime)...[
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                backgroundColor: TColor.PRIMARY,
                onPressed: _startTracking,
                child: Text(
                  "Go!",
                  style: TxtStyle.headSectionExtra,
                ),
              ),
            ),
          ]
          else...[
            SizedBox(
              width: 80,
              height: 80,
              child: FloatingActionButton(
                backgroundColor: TColor.PRIMARY,
                onPressed: _startTracking,
                child: Icon(
                  playButtonState,
                  color: TColor.PRIMARY_TEXT,
                  size: 35,
                ),
              ),
            ),
            if(playButtonState == Icons.play_arrow_rounded && firstTime == false)...[
              SizedBox(width: media.width * 0.02,),
              SizedBox(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  backgroundColor: TColor.WARNING,
                  onPressed: _stopTracking,
                  child: const Icon(
                    Icons.stop_rounded,
                    size: 35,
                  ),
                ),
              ),
            ],
          ]
        ],
      ),
    );
  }
}
//
// class EntryCard extends StatelessWidget {
//   final Entry entry;
//   const EntryCard({super.key, required this.entry});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(entry.date!, style: const TextStyle(fontSize: 18)),
//                   Text("${(entry.distance! / 1000).toStringAsFixed(2)} km",
//                       style: const TextStyle(fontSize: 18)),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(entry.duration!,
//                       style: const TextStyle(fontSize: 14)),
//                   Text("${entry.speed!.toStringAsFixed(2)} km/h",
//                       style: const TextStyle(fontSize: 14)),
//                 ],
//               )
//             ],
//           )),
//     );
//   }
// }
//
// class MapStats extends StatefulWidget {
//   const MapStats({super.key});
//
//   @override
//   State<MapStats> createState() => _MapStatsState();
// }
//
// class _MapStatsState extends State<MapStats> {
//   late List<Entry> _data;
//   List<EntryCard> _cards = [];
//   late DB db;
// // initialize DB and fetch entries for showing items in list
//   @override
//   void initState() {
//     db = DB();
//     WidgetsBinding.instance.addPostFrameCallback((_){
//       db.init().then((value) => _fetchEntries());
//     });
//     super.initState();
//   }
//
//   void _fetchEntries() async {
//     _cards = [];
//
//     try{
//       List<Map<String, dynamic>> results = await db.query(Entry.table);
//       _data = results.map((item) => Entry.fromMap(item)).toList();
//       for (var element in _data) {
//         _cards.add(EntryCard(entry: element));
//       }
//       setState(() {});
//     }catch (e){
//       print(e.toString());
//     }
//   }
//
//   void _addEntries(Entry en) async {
//     db.insert(Entry.table, en);
//     _fetchEntries();
//   }
// // This method checks is __cpLocation permission granted and Location
// // services enable when press floating action button if return value
// // is not null, you Navigator.push works and you go MapPage
//   Future<Position?> getPermission() async{
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return null;
//     }
//     // print('Service Enabled: ${serviceEnabled}');
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return null;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return null;
//     }
//     Position? position = await Geolocator.getLastKnownPosition();{
//       if(position != null){
//         return position;
//       }else{
//         return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       }
//     }
//
//   }
//
// // Alert dialog opening when getPermission() return null
//   Future<void> showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Attention'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Please Open Your Location'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//             children:[
//               const SizedBox(height: 20,),
//               SizedBox(child: FloatingActionButton(
//                 onPressed: () async {
//                   Position? pos = await getPermission();
//                   print('Position: $pos');
//                   if (pos != null) {
// // When pop page in MapPage _addEntries(value) method works and
// // saving records to db and showing in MapStatsPage
//                     Navigator.push(
//                         context, MaterialPageRoute(builder: (context) => const MapPage()))
//                         .then((value) => _addEntries(value));
//                   }else{
//                     showMyDialog();
//                   }
//                 } ,
//                 backgroundColor:Theme.of(context).primaryColor,
//                 child: const Icon(Icons.add,size: 32,),
//               ),),
//               const SizedBox(height: 20,),
//               SizedBox(
//                 height: 300,
//                 child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: _cards.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         elevation: 5,
//                         child: Padding(
//                           padding:  const EdgeInsets.all(10),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(_cards[index].entry.date.toString(),style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
//                                     Text("Duration : ${_cards[index].entry.duration}",style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600)),
//                                   ],),
//                                 const SizedBox(height: 10,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Distance (Km) : ${(_cards[index].entry.distance! / 1000).toStringAsFixed(2)}",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600)),
//                                     Text("Speed (Km/Hours) : ${_cards[index].entry.speed!.toStringAsFixed(2)}",style: const TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w600)),
//                                   ],)
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                 ),
//               ),
//             ]
//         ),
//       ),
//     );
//   }
// }
//
// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   final Set<Polyline> polyline = {};
//   List<LatLng> route = [];
//   double dist = 0;
//   late String displayTime;
//   late int time;
//   late int lastTime;
//   double speed = 0;
//   double avgSpeed = 0;
//   int speedCounter = 0;
//   late bool loadingStatus;
//   late double appendDist;
//   LatLng sourceLocation = const LatLng(37.4219983, -122.084);
//   // LatLng sourceLocation = const LatLng(0, 0);
//   // late LatLng sourceLocation;
//   Position? currentPosition;
//   final Completer<GoogleMapController?> controller = Completer();
//   final StopWatchTimer stopWatchTimer = StopWatchTimer();
//   var mapStyle;
//   late StreamSubscription<Position> positionStream;
//
//   void initSourceLocation() async {
//     // final sourcePosition = await Geolocator.getCurrentPosition(
//     //     desiredAccuracy: LocationAccuracy.high);
//     // setState(() {
//     //   sourceLocation = LatLng(sourcePosition.latitude, sourcePosition.longitude);
//     // });
//   }
//
//   @override
//   void initState() {
//     initSourceLocation();
//     route.clear();
//     polyline.clear();
//     dist = 0;
//     time = 0;
//     lastTime = 0;
//     speed = 0;
//     avgSpeed = 0;
//     speedCounter = 0;
//     appendDist = 0;
//     stopWatchTimer.onResetTimer(); // Reset the timer
//     stopWatchTimer.onStartTimer(); // Start the timer
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   getCurrentPosition();
//     // });
//     move();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     positionStream.cancel();
//     stopWatchTimer.dispose();
//   }
//
//   Future<void> getCurrentPosition() async {
//     // final Random random = Random();
//     // final double latitude = sourceLocation.latitude + random.nextDouble() * 0.1;
//     // final double longitude = sourceLocation.longitude + random.nextDouble() * 0.1;
//     // final double accuracy = random.nextDouble() * 10;
//     // final double altitude = random.nextDouble() * 100;
//     // final double altitudeAccuracy = random.nextDouble() * 5;
//     // final double heading = random.nextDouble() * 360;
//     // final double headingAccuracy = random.nextDouble() * 10;
//     // final DateTime timestamp = DateTime.now().subtract(Duration(seconds: random.nextInt(3600))); // Random timestamp within the last hour
//     // currentPosition = Position(
//     //   latitude: latitude,
//     //   longitude: longitude,
//     //   timestamp: timestamp,
//     //   accuracy: accuracy,
//     //   altitude: altitude,
//     //   altitudeAccuracy: altitudeAccuracy,
//     //   heading: heading,
//     //   headingAccuracy: headingAccuracy,
//     //   speed: speed,
//     //   speedAccuracy: avgSpeed,
//     // );
//     // positionStream.cancel();
//     currentPosition = await Geolocator.getCurrentPosition(
//       forceAndroidLocationManager: true,
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {});
//     print('Current Location: ${currentPosition?.latitude}, ${currentPosition?.longitude}');
//     print('Source Location: ${sourceLocation.latitude}, ${sourceLocation.longitude}');
//     if (currentPosition != null) {
//       late LocationSettings cpLocationSettings;
//       cpLocationSettings = const LocationSettings(
//           accuracy: LocationAccuracy.high, distanceFilter: 10);
//       positionStream =
//           Geolocator.getPositionStream(locationSettings: cpLocationSettings)
//               .listen((Position? position) async {
//             print(position == null
//                 ? 'Unknown'
//                 : '${position.latitude.toString()}, ${position.longitude
//                 .toString()}');
//             currentPosition = position;
//             print('Position Stream: $currentPosition');
//             if (route.isNotEmpty) {
//               appendDist = Geolocator.distanceBetween(route.last.latitude,
//                   route.last.longitude, position!.latitude, position.longitude);
//               dist = dist + appendDist;
//               int timeDuration = (time - lastTime);
//
//               if (timeDuration != 0) {
//                 speed = (appendDist / (timeDuration / 100)) * 3.6;
//                 if (speed != 0) {
//                   avgSpeed = avgSpeed + speed;
//                   speedCounter++;
//                 }
//               }
//             }
//             lastTime = time;
//
//             if (route.isNotEmpty) {
//               if (route.last != LatLng(position!.latitude, position.longitude)) {
//                 route.add(LatLng(position.latitude, position.longitude));
//
//                 polyline.add(Polyline(
//                     polylineId: PolylineId(position.toString()),
//                     visible: true,
//                     points: route,
//                     width: 6,
//                     startCap: Cap.roundCap,
//                     endCap: Cap.roundCap,
//                     color: Colors.blue));
//               }
//             } else {
//               route.add(LatLng(position!.latitude, position.longitude));
//             }
//             print('Route: $route');
//
//             setState(() {});
//           });
//       setState(() {});
//     }
//   }
//   List<LatLng> routeCoordinates = [
//     LatLng(37.7749, -122.4194), // San Francisco (Initial position)
//     LatLng(40.7128, -74.0060), // New York
//     LatLng(34.0522, -118.2437), // Los Angeles
//     LatLng(41.8781, -87.6298), // Chicago
//     LatLng(29.7604, -95.3698), // Houston
//     LatLng(51.5074, -0.1278), // London
//     LatLng(48.8566, 2.3522), // Paris
//     LatLng(35.6895, 139.6917), // Tokyo
//     LatLng(-33.8688, 151.2093), // Sydney
//     LatLng(-23.5505, -46.6333), // Sao Paulo
//     LatLng(55.7558, 37.6176), // Moscow
//   ];
//
//   double latitude = 37.7749; // Initial latitude
//   double longitude = -122.4194; // Initial longitude
//
//   int currentPositionIndex = 0;
//   bool isMoving = false;
//   Random random = Random();
//   void move() {
//     const duration = Duration(seconds: 5); // Time between movements
//
//     Timer.periodic(duration, (timer) {
//       // Check if there are more positions in the route
//       if (currentPositionIndex < routeCoordinates.length - 1) {
//         // Generate random offsets to simulate movement
//         double latOffset = random.nextDouble() * 0.1 - 0.05;
//         double longOffset = random.nextDouble() * 0.1 - 0.05;
//
//         // Update latitude and longitude with random offsets
//         latitude = routeCoordinates[currentPositionIndex].latitude + latOffset;
//         longitude =
//             routeCoordinates[currentPositionIndex].longitude + longOffset;
//
//         // Update UI with new position
//         setState(() {});
//
//         currentPositionIndex++;
//       } else {
//         // Stop the timer if the route ends
//         timer.cancel();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: currentPosition == null
//             ? const Center(
//           child: CircularProgressIndicator(),
//         )
//             : Stack(children: [
//           GoogleMap(
//             polylines: polyline,
//             markers: {
//               Marker(
//                 markerId: MarkerId("sourceLocation"),
//                 position: sourceLocation
//               )
//             },
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             initialCameraPosition: CameraPosition(
//                 target: LatLng(currentPosition!.latitude,
//                     currentPosition!.longitude),
//                 zoom: 13.5),
//             onMapCreated: (mapController) {
//               mapController.setMapStyle(mapStyle);
//               if (controller.isCompleted) {
//                 controller.complete(mapController);
//                 setState(() {});
//               }
//               setState(() {});
//             },
//           ),
//           Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                 height: 125,
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               "Speed (Km/Hours)",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displaySmall!
//                                   .copyWith(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                             Text(
//                               speed.toStringAsFixed(2),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displaySmall!
//                                   .copyWith(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w300),
//                             )
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "Duration",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displaySmall!
//                                   .copyWith(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                             StreamBuilder<int>(
//                               stream: stopWatchTimer.rawTime,
//                               initialData: 0,
//                               builder: (context, snap) {
//                                 time = snap.data!;
//                                 displayTime =
//                                 "${StopWatchTimer.getDisplayTimeHours(time)}:${StopWatchTimer.getDisplayTimeMinute(time)}:${StopWatchTimer.getDisplayTimeSecond(time)}";
//                                 return Text(
//                                   displayTime,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displaySmall!
//                                       .copyWith(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w300),
//                                 );
//                               },
//                             )
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "Distance (Km)",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displaySmall!
//                                   .copyWith(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w300),
//                             ),
//                             Text(
//                               (dist / 1000).toStringAsFixed(2),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displaySmall!
//                                   .copyWith(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w300),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//
//                     // Save activity
//                     const Divider(),
//                     InkWell(
//                       child: const Icon(
//                         Icons.stop_circle_outlined,
//                         size: 45,
//                         color: Colors.redAccent,
//                       ),
//                       onTap: () async {
//                         Entry en = Entry(
//                             date: DateFormat.yMMMMd()
//                                 .format(DateTime.now()),
//                             duration: displayTime,
//                             speed: speedCounter == 0
//                                 ? 0
//                                 : avgSpeed / speedCounter,
//                             distance: dist);
//                          // positionStream.cancel();
//                         Navigator.pop(context, en);
//                       },
//                     ),
//                   ],
//                 ),
//               ))
//         ]));
//   }
// }