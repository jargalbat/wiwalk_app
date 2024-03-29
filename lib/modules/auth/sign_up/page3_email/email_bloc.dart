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
class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailRefresh()) {
    on<ValidateEmailEvent>((event, emit) async {
      bool isValidEmail = Func.isValidEmail(event.email ?? '');

      emit(ValidateEmailState(isValidEmail: isValidEmail));

      emit(EmailRefresh());
    });

    on<GetEmailCodeEvent>((event, emit) async {
      emit(EmailLoadingState());

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
abstract class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}

class ValidateEmailEvent extends EmailEvent {
  final String? email;

  const ValidateEmailEvent({this.email});

  @override
  List<Object> get props => [email ?? ''];
}

class GetEmailCodeEvent extends EmailEvent {
  final EmailCodeRequest request;

  const GetEmailCodeEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailRefresh extends EmailState {}

class EmailLoadingState extends EmailState {}

class ValidateEmailState extends EmailState {
  final bool isValidEmail;

  const ValidateEmailState({required this.isValidEmail});

  @override
  List<Object> get props => [isValidEmail];
}

class GetEmailCodeSuccess extends EmailState {
  final CResponse response;
  final String? email;

  const GetEmailCodeSuccess({required this.response, this.email});

  @override
  List<Object> get props => [response, email ?? ''];
}

class GetEmailCodeFailed extends EmailState {
  final String message;

  const GetEmailCodeFailed({required this.message});

  @override
  List<Object> get props => [message];
}
