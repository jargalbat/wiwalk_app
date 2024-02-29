import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final int _duration;
  Timer? _timer;

  TimerBloc(this._duration) : super(TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerReset>(_onReset);
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(_duration));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TimerTicked(_duration - timer.tick));
    });
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : TimerRunComplete());
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerInitial(_duration));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class TimerEvent {}

class TimerStarted extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int duration;

  TimerTicked(this.duration);
}

class TimerReset extends TimerEvent {}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class TimerState {}

class TimerInitial extends TimerState {
  final int duration;

  TimerInitial(this.duration);
}

class TimerRunInProgress extends TimerState {
  final int duration;

  TimerRunInProgress(this.duration);
}

class TimerRunComplete extends TimerState {}
