import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/verify_phone_request.dart';
import 'package:wiwalk_app/data/models/c_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  VerifyPhoneBloc() : super(VerifyPhoneRefresh()) {
    on<ValidatePhoneCodeEvent>((event, emit) async {
      bool isValidCode = Func.isFourDigits(event.code ?? '');

      emit(ValidatePhoneCodeState(isValidCode: isValidCode));

      emit(VerifyPhoneRefresh());
    });

    on<VerifyPhone>((event, emit) async {
      emit(VerifyPhoneLoadingState());

      // if (kDebugMode) {
      //   emit(GetPhoneCodeSuccess(response: PhoneCodeResponse()));
      //   return;
      // }

      final response = await cClient.sendRequest(
        path: ApiPaths.phoneConfirm,
        requestData: event.request.toJson(),
      );

      CResponse cResponse = CResponse.fromJson(response.data);
      if (cResponse.retType == 0) {
        emit(VerifyPhoneSuccess(response: cResponse));
      } else {
        emit(
          VerifyPhoneFailed(message: cResponse.retDesc ?? 'Амжилтгүй'),
        );
      }
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class VerifyPhoneEvent extends Equatable {
  const VerifyPhoneEvent();

  @override
  List<Object> get props => [];
}

class ValidatePhoneCodeEvent extends VerifyPhoneEvent {
  final String? code;

  const ValidatePhoneCodeEvent({this.code});

  @override
  List<Object> get props => [code ?? ''];
}

class VerifyPhone extends VerifyPhoneEvent {
  final VerifyPhoneRequest request;

  const VerifyPhone({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class VerifyPhoneState extends Equatable {
  const VerifyPhoneState();

  @override
  List<Object> get props => [];
}

class VerifyPhoneRefresh extends VerifyPhoneState {}

class VerifyPhoneLoadingState extends VerifyPhoneState {}

class ValidatePhoneCodeState extends VerifyPhoneState {
  final bool isValidCode;

  const ValidatePhoneCodeState({required this.isValidCode});

  @override
  List<Object> get props => [isValidCode];
}

class VerifyPhoneSuccess extends VerifyPhoneState {
  final CResponse response;

  const VerifyPhoneSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class VerifyPhoneFailed extends VerifyPhoneState {
  final String message;

  const VerifyPhoneFailed({required this.message});

  @override
  List<Object> get props => [message];
}
