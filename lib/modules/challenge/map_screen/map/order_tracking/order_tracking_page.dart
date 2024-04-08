import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:wiwalk_app/modules/challenge/map_screen/geo_locator_helper.dart';
// import 'package:location/location.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';

import '../../constants.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
// Google map
  final Completer<GoogleMapController> _controller = Completer();
  final double _zoom = 14.5;

  // Location
  LatLng? _currentLocation;
  static const LatLng _sourceLocation = LatLng(47.9142963161, 106.91627601);
  static const LatLng _destinationLocation = LatLng(47.9228, 106.9048);

  // Coordinates
  final PolylinePoints _polylinePoints = PolylinePoints();
  final List<LatLng> _polylineCoordinates = [];

  // Bitmap
  BitmapDescriptor _sourceLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinationLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _currentLocaitonIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Map order tracking',
      body: _currentLocation == null
          ? const Text('Loading...')
          : GoogleMap(
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
              initialCameraPosition: CameraPosition(
                // target: _sourceLocation,
                target: _currentLocation!,
                zoom: _zoom,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: _polylineCoordinates,
                  color: primaryColor,
                  width: 6,
                )
              },
              // polygons: {
              //   Polygon(
              //     polygonId: const PolygonId('route'),
              //     points: _polylineCoordinates,
              //   )
              // },
              markers: {
                if (_currentLocation != null)
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: _currentLocation!,
                    icon: _currentLocaitonIcon,
                  ),
                Marker(
                  markerId: MarkerId('sourceLocation'),
                  position: _sourceLocation,
                  icon: _sourceLocationIcon,
                ),
                Marker(
                  markerId: MarkerId('destinationLocation'),
                  position: _destinationLocation,
                  icon: _destinationLocationIcon,
                ),
              },
            ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     const SizedBox(width: 40.0),
      //     FloatingActionButton(
      //       onPressed: () {
      //         setState(() {
      //           _zoom += 1;
      //         });
      //       },
      //       child: const Icon(Icons.add),
      //     ),
      //     const SizedBox(width: 20.0),
      //     FloatingActionButton(
      //       onPressed: () {
      //         setState(() {
      //           _zoom -= 1;
      //         });
      //       },
      //       child: const Icon(Icons.remove),
      //     ),
      //     const SizedBox(width: 20.0),
      //     Text('Zoom: $_zoom'),
      //   ],
      // ),
    );
  }

  Future<void> _initPage() async {
    _setCustomMarkerIcon();
    await _getCurrentLocation();
    _getPolyPoints();
  }

  Future<void> _getPolyPoints() async {
    PolylineResult polylineResult =
        await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
      PointLatLng(
        _destinationLocation.latitude,
        _destinationLocation.longitude,
      ),

      travelMode: TravelMode.walking,
      // List<PolylineWayPoint> wayPoints = const [],
      avoidHighways: false,
      avoidTolls: false,
      avoidFerries: false,
      optimizeWaypoints: false,
    );

    if (polylineResult.points.isNotEmpty) {
      for (var el in polylineResult.points) {
        _polylineCoordinates.add(
          LatLng(el.latitude, el.longitude),
        );
      }

      setState(() {});
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Init
      // GoogleMapController googleMapController = await _controller.future;

      Position? position = await determinePosition();
      if (position?.latitude != null && position?.longitude != null) {
        _currentLocation =
            LatLng(position!.latitude, position.longitude);
      }

      // Listener
      // location.onLocationChanged.listen((newLocation) async {
      //   if (newLocation.latitude != null && newLocation.longitude != null) {
      //     _currentLocation = LatLng(
      //       newLocation.latitude!,
      //       newLocation.longitude!,
      //     );
      //
      //     // GoogleMapController googleMapController = await _controller.future;
      //     //
      //     // googleMapController.animateCamera(
      //     //   CameraUpdate.newCameraPosition(
      //     //     CameraPosition(
      //     //       zoom: _zoom,
      //     //       target: _currentLocation!,
      //     //     ),
      //     //   ),
      //     // );
      //
      //     setState(() {});
      //   }
      // });


    } catch (e) {
      print(e);
    }
  }

  void _setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'images/jagaa.png',
    ).then((value) => _currentLocaitonIcon = value);

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/pin.png',
    ).then((value) => _sourceLocationIcon = value);

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/pin.png',
    ).then((value) => _destinationLocationIcon = value);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
