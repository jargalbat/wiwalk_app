import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/c_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/data/models/group_challenge.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class CMapBloc extends Bloc<CMapEvent, CMapState> {
  CMapBloc() : super(CMapRefresh()) {
    // on<PedestrianStatusChangeEvent>((event, emit) async {
    //   emit(PedestrianStatusChangeState(status: event.status));
    //   emit(CMapRefresh());
    // });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class CMapEvent extends Equatable {
  const CMapEvent();

  @override
  List<Object> get props => [];
}

// class PedestrianStatusChangeEvent extends CMapEvent {
//   final String status;
//
//   const PedestrianStatusChangeEvent({required this.status});
//
//   @override
//   List<Object> get props => [status];
// }

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class CMapState extends Equatable {
  const CMapState();

  @override
  List<Object> get props => [];
}

class CMapRefresh extends CMapState {}
//
// class PedestrianStatusChangeState extends CMapState {
//   final String status;
//
//   const PedestrianStatusChangeState({required this.status});
//
//   @override
//   List<Object> get props => [status];
// }
