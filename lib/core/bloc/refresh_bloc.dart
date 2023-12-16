import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  RefreshBloc() : super(RefreshInitState()) {
    on<RefreshChallengeTodayEvent>((event, emit) {
      emit(RefreshChallengeTodayState());
      emit(RefreshInitState());
    });

    on<RefreshProfileEvent>((event, emit) {
      emit(RefreshProfileState());
      emit(RefreshInitState());
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class RefreshEvent extends Equatable {
  const RefreshEvent();

  @override
  List<Object> get props => [];
}

class RefreshChallengeTodayEvent extends RefreshEvent {}

class RefreshProfileEvent extends RefreshEvent {}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class RefreshState extends Equatable {
  const RefreshState();

  @override
  List<Object> get props => [];
}

class RefreshInitState extends RefreshState {}

class RefreshChallengeTodayState extends RefreshState {}

class RefreshProfileState extends RefreshState {}
