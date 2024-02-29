import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/phone_code_request.dart';
import 'package:wiwalk_app/data/models/auth/phone_code_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc() : super(PhoneRefresh()) {
    on<ValidatePhoneEvent>((event, emit) async {
      bool isValidPhone = Func.isEightDigits(event.phone ?? '');

      emit(ValidatePhoneState(isValidPhone: isValidPhone));

      emit(PhoneRefresh());
    });

    on<GetPhoneCodeEvent>((event, emit) async {
      emit(PhoneLoadingState());

      // if (kDebugMode) {
      //   emit(GetPhoneCodeSuccess(response: PhoneCodeResponse()));
      //   return;
      // }

      final response = await cClient.sendRequest(
        path: ApiPaths.phoneReg,
        requestData: event.request.toJson(),
      );

      PhoneCodeResponse phoneResponse =
          PhoneCodeResponse.fromJson(response.data);
      if (phoneResponse.retType == 0) {
        emit(
          GetPhoneCodeSuccess(
            response: phoneResponse,
            phone: event.request.phone,
          ),
        );
      } else {
        emit(
          GetPhoneCodeFailed(
            message: phoneResponse.retDesc ?? 'Амжилтгүй',
          ),
        );
      }
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class PhoneEvent extends Equatable {
  const PhoneEvent();

  @override
  List<Object> get props => [];
}

class ValidatePhoneEvent extends PhoneEvent {
  final String? phone;

  const ValidatePhoneEvent({this.phone});

  @override
  List<Object> get props => [phone ?? ''];
}

class GetPhoneCodeEvent extends PhoneEvent {
  final PhoneCodeRequest request;

  const GetPhoneCodeEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class PhoneState extends Equatable {
  const PhoneState();

  @override
  List<Object> get props => [];
}

class PhoneRefresh extends PhoneState {}

class PhoneLoadingState extends PhoneState {}

class ValidatePhoneState extends PhoneState {
  final bool isValidPhone;

  const ValidatePhoneState({
    required this.isValidPhone,
  });

  @override
  List<Object> get props => [isValidPhone];
}

class GetPhoneCodeSuccess extends PhoneState {
  final PhoneCodeResponse response;
  final String? phone;

  const GetPhoneCodeSuccess({
    required this.response,
    this.phone,
  });

  @override
  List<Object> get props => [response, phone ?? ''];
}

class GetPhoneCodeFailed extends PhoneState {
  final String message;

  const GetPhoneCodeFailed({required this.message});

  @override
  List<Object> get props => [message];
}
