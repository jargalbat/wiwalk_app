import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/auth/email_code_request.dart';
import 'package:wiwalk_app/data/models/c_request.dart';
import 'package:wiwalk_app/data/models/dictionary/educations_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoRefresh()) {
    on<GetEducations>((event, emit) async {
      emit(UserInfoLoadingState());

      final response = await cClient.sendRequest(
        path: ApiPaths.educations,
        requestData: CRequest(),
      );

      var eduResponse = EducationsResponse.fromJson(response.data);
      Map<String, String> educations = <String, String>{};
      for (var el in eduResponse.educations ?? []) {
        if (el.educationId != null && el.education != null) {
          educations[el.educationId!] = el.education!;
        }
      }

      if (eduResponse.retType == 0 && educations.isNotEmpty) {
        emit(FetchedEducations(educations: educations));
      } else {
        emit(
          FetchEducationsFailed(
            message: 'Боловсролын жагсаалт олдсонгүй. Дахин бүртгүүлнэ үү! '
                '${eduResponse.retDesc ?? ''}',
          ),
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

class GetEducations extends UserInfoEvent {
  final String? email;

  const GetEducations({this.email});

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

class FetchedEducations extends UserInfoState {
  final Map<String, String> educations;

  const FetchedEducations({required this.educations});

  @override
  List<Object> get props => [educations];
}

class FetchEducationsFailed extends UserInfoState {
  final String message;

  const FetchEducationsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
