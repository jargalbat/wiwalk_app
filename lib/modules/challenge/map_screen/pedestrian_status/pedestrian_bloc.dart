import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class PedestrianBloc extends Bloc<PedestrianEvent, PedestrianState> {
  PedestrianBloc() : super(PedestrianRefresh()) {
    on<PedestrianStatusChangedEvent>((event, emit) async {
      emit(PedestrianStatusChangedState(status: event.status));
      emit(PedestrianRefresh());
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class PedestrianEvent extends Equatable {
  const PedestrianEvent();

  @override
  List<Object> get props => [];
}

class PedestrianStatusChangedEvent extends PedestrianEvent {
  final String status;

  const PedestrianStatusChangedEvent({required this.status});

  @override
  List<Object> get props => [status];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class PedestrianState extends Equatable {
  const PedestrianState();

  @override
  List<Object> get props => [];
}

class PedestrianRefresh extends PedestrianState {}

class PedestrianStatusChangedState extends PedestrianState {
  final String status;

  const PedestrianStatusChangedState({required this.status});

  @override
  List<Object> get props => [status];
}
