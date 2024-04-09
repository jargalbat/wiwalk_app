import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wiwalk_app/modules/challenge/map_screen/pedestrian_status/pedestrian_bloc.dart';

class PedestrianStatusWidget extends StatefulWidget {
  const PedestrianStatusWidget({super.key});

  @override
  State<PedestrianStatusWidget> createState() => _PedestrianStatusWidgetState();
}

class _PedestrianStatusWidgetState extends State<PedestrianStatusWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  String _status = '?';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PedestrianBloc, PedestrianState>(
      listener: _pedestrianListener,
      child: BlocBuilder<PedestrianBloc, PedestrianState>(
        builder: (BuildContext context, PedestrianState state) {
          return Lottie.asset(
            'assets/lotties/walk.json',
            controller: _controller,
            height: 38.0,
            width: 60.0,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
          );
        },
      ),
    );
  }

  void _pedestrianListener(BuildContext context, PedestrianState state) {
    if (state is PedestrianStatusChangedState) {
      _status = state.status;
      debugPrint('PedestrianStatus: $_status');
      if (_status == 'walking') {
        _controller.repeat();
      } else {
        _controller.forward();
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
