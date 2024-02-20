import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class SignUpScreenBloc extends Bloc<SignUpScreenEvent, SignUpScreenState> {
  String? userId;

  SignUpScreenBloc() : super(SignUpScreenRefresh()) {
    on<SignUpPrevPageEvent>((event, emit) async {
      emit(SignUpPrevPageState());
      emit(SignUpScreenRefresh());
    });

    on<SignUpNextPageEvent>((event, emit) async {
      emit(SignUpNextPageState());
      emit(SignUpScreenRefresh());
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class SignUpScreenEvent extends Equatable {
  const SignUpScreenEvent();

  @override
  List<Object> get props => [];
}

class SignUpPrevPageEvent extends SignUpScreenEvent {}

class SignUpNextPageEvent extends SignUpScreenEvent {}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class SignUpScreenState extends Equatable {
  const SignUpScreenState();

  @override
  List<Object> get props => [];
}

class SignUpScreenRefresh extends SignUpScreenState {}

class SignUpNextPageState extends SignUpScreenState {}

class SignUpPrevPageState extends SignUpScreenState {}
