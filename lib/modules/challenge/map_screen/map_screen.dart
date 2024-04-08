import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'constants.dart';
import 'geo_locator_helper.dart';
import 'location_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  // LocationData? _currentLocation;

  double _originLatitude = 47.9142963161, _originLongitude = 106.91627601;
  double _destLatitude = 47.9228, _destLongitude = 106.9048;

  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();

    _originLatitude = 47.9188;
    _originLongitude = 106.9176;

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    // _getPolyline();

    // _getCurrentLocation();

    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Map polyline',
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            // markers: Set<Marker>.of(markers.values),
            // polylines: Set<Polyline>.of(polylines.values),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.walking,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  // _getCurrentLocation() async {
  //   // LocationHelper.getCurrentLocation().then((location) {
  //   //   setState(() {
  //   //     _currentLocation = location;
  //   //   });
  //   // });
  //
  //   _currentLocation = await LocationHelper.getCurrentLocation();
  //   if (_currentLocation != null) {
  //     // Animate camera to the current location
  //     // _mapController.animateCamera(
  //     //   CameraUpdate.newCameraPosition(
  //     //     CameraPosition(
  //     //       target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
  //     //       zoom: 15.0, // You can adjust the zoom level as needed
  //     //     ),
  //     //   ),
  //     // );
  //
  //     // Optionally, add a marker for the current location
  //     // _addMarker(
  //     //   LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
  //     //   "current_location",
  //     //   BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //     // );
  //
  //     // If you want to draw a polyline from the current location to a destination, you can call _getPolyline() here
  //     // _getPolyline();
  //
  //     // setState(() {}); // This will trigger a rebuild if needed
  //   }
  // }

  void _determinePosition() async {
    Position? position = await determinePosition();
    if (position != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0, // You can adjust the zoom level as needed
          ),
        ),
      );
    }
    print(position);
  }
}
