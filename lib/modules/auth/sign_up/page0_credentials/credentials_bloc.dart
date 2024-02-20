import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/sign_up_request.dart';
import 'package:wiwalk_app/data/models/auth/sign_up_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(CredentialsRefresh()) {
    on<CredentialsValidateUsernameEvent>((event, emit) async {
      bool isValidEmail1 = Func.isValidEmail(event.username ?? '');
      bool isValidPhone1 = Func.isEightDigits(event.username ?? '');

      emit(
        CredentialsValidateUsernameState(
          isValidEmail: isValidEmail1,
          isValidPhone: isValidPhone1,
        ),
      );

      emit(CredentialsRefresh());
    });

    on<CredentialsValidatePassEvent>((event, emit) async {
      bool valid1 = Func.hasMinimumLength(event.pass1 ?? '');
      bool valid2 = Func.hasUppercaseLetter(event.pass1 ?? '');
      bool valid3 = Func.hasLowercaseLetter(event.pass1 ?? '');
      bool valid4 = Func.isNotEmpty(event.pass1) && event.pass1 == event.pass2;

      emit(
        CredentialsValidatePassState(
          isValid1: valid1,
          isValid2: valid2,
          isValid3: valid3,
          isValid4: valid4,
        ),
      );

      emit(CredentialsRefresh());
    });

    on<SignUpEvent>((event, emit) async {
      emit(CredentialsLoadingState());

      if (kDebugMode) {
        emit(
          SignUpSuccess(
            response: SignUpResponse(
              userId: 'za522637af03aa4b36bb320691de619bf2',
            ),
          ),
        );
        return;
      }

      final response = await cClient.sendRequest(
        path: ApiPaths.signUp,
        requestData: event.request.toJson(),
      );

      SignUpResponse signUpResponse = SignUpResponse.fromJson(response.data);
      if (signUpResponse.retType == 0 && signUpResponse.userId != null) {
        emit(SignUpSuccess(response: signUpResponse));
      } else {
        emit(
          SignUpFailed(
            message: signUpResponse.retDesc ?? 'Амжилтгүй',
          ),
        );
      }
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class CredentialsEvent extends Equatable {
  const CredentialsEvent();

  @override
  List<Object> get props => [];
}

class CredentialsValidateUsernameEvent extends CredentialsEvent {
  final String? username;

  const CredentialsValidateUsernameEvent({this.username});

  @override
  List<Object> get props => [username ?? ''];
}

class CredentialsValidatePassEvent extends CredentialsEvent {
  final String? pass1;
  final String? pass2;

  const CredentialsValidatePassEvent({this.pass1, this.pass2});

  @override
  List<Object> get props => [pass1 ?? '', pass2 ?? ''];
}

class SignUpEvent extends CredentialsEvent {
  final SignUpRequest request;

  const SignUpEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

class CredentialsRefresh extends CredentialsState {}

class CredentialsLoadingState extends CredentialsState {}

class CredentialsValidatePassState extends CredentialsState {
  final bool isValid1;
  final bool isValid2;
  final bool isValid3;
  final bool isValid4;

  const CredentialsValidatePassState({
    required this.isValid1,
    required this.isValid2,
    required this.isValid3,
    required this.isValid4,
  });

  @override
  List<Object> get props => [isValid1, isValid2, isValid3, isValid4];
}

class CredentialsValidateUsernameState extends CredentialsState {
  final bool isValidEmail;
  final bool isValidPhone;

  const CredentialsValidateUsernameState({
    required this.isValidEmail,
    required this.isValidPhone,
  });

  @override
  List<Object> get props => [isValidEmail, isValidPhone];
}

class SignUpSuccess extends CredentialsState {
  final SignUpResponse response;

  const SignUpSuccess({required this.response});

  @override
  List<Object> get props => [response ?? SignUpResponse()];
}

class SignUpFailed extends CredentialsState {
  final String message;

  const SignUpFailed({required this.message});

  @override
  List<Object> get props => [message];
}
