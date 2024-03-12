import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/verify_email_request.dart';
import 'package:wiwalk_app/data/models/c_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailRefresh()) {
    on<ValidateEmailCodeEvent>((event, emit) async {
      // todo jagaa 4
      bool isValidCode = Func.isValidDigits(event.code ?? '', 5);

      emit(ValidateEmailCodeState(isValidCode: isValidCode));

      emit(VerifyEmailRefresh());
    });

    on<VerifyEmail>((event, emit) async {
      emit(VerifyEmailLoadingState());

      if (kDebugMode) {
        emit(VerifyEmailSuccess(response: CResponse()));
        return;
      }

      final response = await cClient.sendRequest(
        path: ApiPaths.emailConfirm,
        requestData: event.request.toJson(),
      );

      CResponse cResponse = CResponse.fromJson(response.data);
      if (cResponse.retType == 0) {
        emit(VerifyEmailSuccess(response: cResponse));
      } else {
        emit(
          VerifyEmailFailed(message: cResponse.retDesc ?? 'Амжилтгүй'),
        );
      }
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmailCodeEvent extends VerifyEmailEvent {
  final String? code;

  const ValidateEmailCodeEvent({this.code});

  @override
  List<Object> get props => [code ?? ''];
}

class VerifyEmail extends VerifyEmailEvent {
  final VerifyEmailRequest request;

  const VerifyEmail({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailRefresh extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}

class ValidateEmailCodeState extends VerifyEmailState {
  final bool isValidCode;

  const ValidateEmailCodeState({required this.isValidCode});

  @override
  List<Object> get props => [isValidCode];
}

class VerifyEmailSuccess extends VerifyEmailState {
  final CResponse response;

  const VerifyEmailSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class VerifyEmailFailed extends VerifyEmailState {
  final String message;

  const VerifyEmailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
