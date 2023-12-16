import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/api_helper.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/login_request.dart';
import 'package:wiwalk_app/data/models/auth/login_response.dart';
import 'package:wiwalk_app/data/models/auth/sign_up_request.dart';
import 'package:wiwalk_app/data/models/auth/sign_up_response.dart';

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

    on<SignUpCredentialsEvent>((event, emit) async {
      emit(SignUpLoadingState());

      final response = await cClient.sendRequest(
        httpMethod: HttpMethod.get,
        path: ApiPaths.auth,
        requestData: event.request,
      );

      SignUpResponse signUpResponse = SignUpResponse.fromJson(response.data);
      if (signUpResponse.retType == 0) {
        emit(SignUpSuccess(response: signUpResponse));
      } else {
        emit(SignUpFailed(message: signUpResponse.retDesc ?? 'Амжилтгүй'));
      }
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

class SignUpCredentialsEvent extends SignUpEvent {
  final SignUpRequest request;

  const SignUpCredentialsEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpRefresh extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpNextPageState extends SignUpState {}

class SignUpPrevPageState extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignUpResponse response;

  const SignUpSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class SignUpFailed extends SignUpState {
  final String message;

  const SignUpFailed({required this.message});

  @override
  List<Object> get props => [message];
}
