import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  RefreshBloc() : super(RefreshEmptyState()) {
    on<RefreshChallengeTodayEvent>((event, emit) {
      emit(RefreshChallengeTodayState());
      emit(RefreshEmptyState());
    });

    on<RefreshProfileEvent>((event, emit) {
      emit(RefreshProfileState());
      emit(RefreshEmptyState());
    });

    on<DanAuthSuccessEvent>((event, emit) {
      emit(DanAuthSuccessState(token: event.token));
      emit(RefreshEmptyState());
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

class DanAuthSuccessEvent extends RefreshEvent {
  final String token;

  const DanAuthSuccessEvent({required this.token});

  @override
  List<Object> get props => [token];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class RefreshState extends Equatable {
  const RefreshState();

  @override
  List<Object> get props => [];
}

class RefreshEmptyState extends RefreshState {}

class RefreshChallengeTodayState extends RefreshState {}

class RefreshProfileState extends RefreshState {}

class DanAuthSuccessState extends RefreshState {
  final String token;

  const DanAuthSuccessState({required this.token});

  @override
  List<Object> get props => [token];
}
