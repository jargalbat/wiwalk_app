import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';
import 'package:wiwalk_app/data/api/api_helper.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/login_request.dart';
import 'package:wiwalk_app/data/models/auth/login_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC - Global data refresher bloc
/// ----------------------------------------------------------------------------
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoggedIn = false;

  AuthBloc() : super(AuthRefresh()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      // var data = {
      //   "APIUser": "Walk",
      //   "APIKey": "Walk1!",
      //   "UserName": "95770077",
      //   "PassCode": "1111"
      // };

      final response = await cClient.sendRequest(
        path: ApiPaths.login,
        requestData: event.request.toJson(),
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.retType == 0 && loginResponse.token != null) {
        await sharedPref.setString(
          SharedPrefKeys.accessToken,
          loginResponse.token!,
        );

        emit(LoginSuccess(response: loginResponse));
      } else {
        emit(LoginFailed(message: loginResponse.retDesc ?? 'Амжилтгүй'));
      }

      emit(AuthRefresh());
    });

    on<UnauthenticatedEvent>((event, emit) {
      emit(UnauthenticatedState());
      emit(AuthRefresh());
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginRequest request;

  const LoginEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class UnauthenticatedEvent extends AuthEvent {}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthRefresh extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginResponse response;

  const LoginSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class LoginFailed extends AuthState {
  final String message;

  const LoginFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class UnauthenticatedState extends AuthState {}
