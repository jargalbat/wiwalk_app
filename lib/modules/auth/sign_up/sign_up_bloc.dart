import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/api_helper.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/login_request.dart';
import 'package:wiwalk_app/data/models/auth/login_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isLoggedIn = false;

  SignUpBloc() : super(SignUpRefresh()) {
    on<SignUpPrevPageEvent>((event, emit) async {
      emit(SignUpPrevPageState());
      emit(SignUpRefresh());
    });

    on<SignUpNextPageEvent>((event, emit) async {
      emit(SignUpNextPageState());
      emit(SignUpRefresh());
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpPrevPageEvent extends SignUpEvent {}

class SignUpNextPageEvent extends SignUpEvent {}

// class SignUpChangePageEvent extends SignUpEvent {
//   final int index;
//
//   const SignUpChangePageEvent({required this.index});
//
//   @override
//   List<Object> get props => [index];
// }

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpRefresh extends SignUpState {}

class SignUpNextPageState extends SignUpState {}

class SignUpPrevPageState extends SignUpState {}

// class SignUpPageChangedState extends SignUpState {
//   final int index;
//
//   const SignUpPageChangedState({required this.index});
//
//   @override
//   List<Object> get props => [index];
// }
