import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/modules/challenge/map_screen/c_map_bloc.dart';
import 'package:wiwalk_app/modules/challenge/map_screen/pedestrian_status/pedestrian_bloc.dart';

// import 'package:location/location.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/c_toast.dart';
import 'constants.dart';
import 'geo_locator_helper.dart';
import 'location_helper.dart';
import 'pedestrian_status/pedestrian_status_widget.dart';

class CMapScreen extends StatelessWidget {
  const CMapScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CMapBloc>(create: (_) => CMapBloc()),
        BlocProvider<PedestrianBloc>(create: (_) => PedestrianBloc()),
      ],
      child: CMapScreenBody(challengeId: challengeId),
    );
  }
}

class CMapScreenBody extends StatefulWidget {
  const CMapScreenBody({super.key, required this.challengeId});

  final String challengeId;

  @override
  State<CMapScreenBody> createState() => _CMapScreenBodyState();
}

class _CMapScreenBodyState extends State<CMapScreenBody> {
  // State
  CMapBloc get _mapBloc => context.read<CMapBloc>();

  PedestrianBloc get _pedestrianBloc => context.read<PedestrianBloc>();

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

  // Pedometer
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  String? _stepsMessage;
  int _steps = 0;

  // Pos
  List<int> _stepsList = [];
  List<Position> _positions = [];

  //
  bool _isStarted = false;

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

    _initPlatformState();

    // showCustomBottomSheet(
    //   context: context,
    //   height: MediaQuery.of(context).size.height * .9,
    //   child: _bottomSheet(context),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Алхалт',
      bodySafeArea: false,
      body: BlocListener<CMapBloc, CMapState>(
        listener: _listener,
        child: BlocBuilder<CMapBloc, CMapState>(
          builder: (BuildContext context, CMapState state) {
            return Stack(
              children: [
                // Map
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(_originLatitude, _originLongitude),
                      zoom: 15),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  // markers: Set<Marker>.of(markers.values),
                  // polylines: Set<Polyline>.of(polylines.values),
                ),

                // Top status
                _statusWidget(),

                // Locations
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Text('steps: $_steps'),
                      ),
                      for (int i = 0; i < _positions.length; i++)
                        Container(
                          color: Colors.white,
                          child: Text(
                            'steps: ${_stepsList[i]}, '
                            'lat: ${_positions[i].latitude.toStringAsFixed(5)}, '
                            'lang: ${_positions[i].longitude.toStringAsFixed(5)} ',
                          ),
                        ),
                    ],
                  ),
                ),

                // Pedometer
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: _pedometer(),
                ),

                // Positioned(
                //   bottom: 0, // Aligns the Container to the bottom of the Stack
                //   left: 0, // Aligns the Container to the left of the Stack
                //   right: 0,
                //   child: Container(
                //     height: 146.0,
                //     decoration: const BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [Colors.white10, Colors.white],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isStarted = !_isStarted;
          });
        },
        child: Icon(_isStarted ? Icons.pause : Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _listener(BuildContext context, CMapState state) {
    // if (state is PedestrianWalkingState) {
    //   _status = true;
    // } else if (state is FetchChallengeDetailFailed) {
    //   showCustomDialog(
    //     context,
    //     dialogType: DialogType.error,
    //     text: state.message,
    //     button2Text: 'Ok',
    //   );
    // }
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

      _stepsList.add(_steps);
      _positions.add(position);
      showToast('Position added');
      setState(() {});
    }
    print(position);
  }

  void _initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    print(event);

    if (event.steps - _steps > 10) {
      _steps = event.steps;
      _determinePosition();
    }

    setState(() {});
    print('steps: $_steps');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print('ped');
    print(event);
    _pedestrianBloc.add(PedestrianStatusChangedEvent(status: event.status));
    _status = event.status;

    // setState(() {
    //   _status = event.status;
    // });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _stepsMessage = 'Step Count not available';
    });
  }

  // Widget _statusWidget() {
  //   return Icon(
  //     _status == 'walking'
  //         ? Icons.directions_walk
  //         : _status == 'stopped'
  //             ? Icons.accessibility_new
  //             : Icons.error,
  //     size: 100,
  //   );
  // }

  Widget _statusWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: CSize.spacing8,
        horizontal: CSize.spacing24,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Эхлэсэн'),
                  Text('8:02 ~ 1мин'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: const PedestrianStatusWidget(),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '0.1км',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pedometer() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text(
            'Steps Taken',
            style: TextStyle(color: Colors.red),
          ),
          Text(
            '$_steps',
            style: const TextStyle(fontSize: 30, color: Colors.red),
          ),
          if (_stepsMessage != null)
            Text(
              _stepsMessage!,
              style: const TextStyle(fontSize: 60),
            ),

          SizedBox(height: 30.0,)
          // const Divider(
          //   height: 100,
          //   thickness: 0,
          //   color: Colors.white,
          // ),
          // const Text(
          //   'Pedestrian Status',
          //   style: TextStyle(fontSize: 30),
          // ),

          // Center(
          //   child: Text(
          //     _status,
          //     style: _status == 'walking' || _status == 'stopped'
          //         ? const TextStyle(fontSize: 30)
          //         : const TextStyle(fontSize: 20, color: Colors.red),
          //   ),
          // )
        ],
      ),
    );
  }
}
