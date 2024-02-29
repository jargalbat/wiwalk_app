import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/email_code_request.dart';
import 'package:wiwalk_app/data/models/auth/phone_code_response.dart';
import 'package:wiwalk_app/data/models/c_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoRefresh()) {
    on<ValidateEmailEvent>((event, emit) async {
      bool isValidEmail = Func.isValidEmail(event.email ?? '');

      emit(ValidateEmailState(isValidEmail: isValidEmail));

      emit(UserInfoRefresh());
    });

    on<GetEmailCodeEvent>((event, emit) async {
      emit(UserInfoLoadingState());

      final response = await cClient.sendRequest(
        path: ApiPaths.emailReg,
        requestData: event.request.toJson(),
      );

      CResponse cResponse = CResponse.fromJson(response.data);
      if (cResponse.retType == 0) {
        emit(
          GetEmailCodeSuccess(response: cResponse, email: event.request.email),
        );
      } else {
        emit(
          GetEmailCodeFailed(message: cResponse.retDesc ?? 'Амжилтгүй'),
        );
      }
    });
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmailEvent extends UserInfoEvent {
  final String? email;

  const ValidateEmailEvent({this.email});

  @override
  List<Object> get props => [email ?? ''];
}

class GetEmailCodeEvent extends UserInfoEvent {
  final EmailCodeRequest request;

  const GetEmailCodeEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoRefresh extends UserInfoState {}

class UserInfoLoadingState extends UserInfoState {}

class ValidateEmailState extends UserInfoState {
  final bool isValidEmail;

  const ValidateEmailState({required this.isValidEmail});

  @override
  List<Object> get props => [isValidEmail];
}

class GetEmailCodeSuccess extends UserInfoState {
  final CResponse response;
  final String? email;

  const GetEmailCodeSuccess({required this.response, this.email});

  @override
  List<Object> get props => [response, email ?? ''];
}

class GetEmailCodeFailed extends UserInfoState {
  final String message;

  const GetEmailCodeFailed({required this.message});

  @override
  List<Object> get props => [message];
}
