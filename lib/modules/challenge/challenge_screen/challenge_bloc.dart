import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/c_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_startstop_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/data/models/group_challenge.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  ChallengeBloc() : super(ChallengeRefresh()) {
    on<GetChallengeDetail>((event, emit) async {
      try {
        emit(ChallengeLoading());

        final response = await cClient.sendRequest(
          path: ApiPaths.challengeDetail,
          requestData: event.request.toJson(),
        );

        var cRes = ChallengeDetailResponse.fromJson(response.data);
        if (cRes.retType == 0 && cRes.challenge != null) {
          emit(GetChallengeDetailSuccess(challenge: cRes.challenge!));
        } else {
          emit(
            GetChallengeDetailFailed(
              message: CResponse.getMessage(cRes, 'Мэдээлэл олдсонгүй'),
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) print(e);
        emit(GetChallengeDetailFailed(message: 'Алдаа гарлаа. $e'));
      }

      emit(ChallengeRefresh());
    });

    on<StartStopChallenge>((event, emit) async {
      try {
        emit(ChallengeLoading());

        final response = await cClient.sendRequest(
          path: ApiPaths.challengeSave,
          requestData: event.request.toJson(),
        );

        var cRes = CResponse.fromJson(response.data);
        if (cRes.retType == 0) {
          emit(ChallengeStartedState());
        } else {
          emit(ChallengeStoppedState());
        }
      } catch (e) {
        if (kDebugMode) print(e);
        emit(ChallengeErrorState(message: 'Алдаа гарлаа. $e'));
      }

      emit(ChallengeRefresh());
    });
  }

  List<ChallengeItem> filterChallengeItemsByMain(
      List<ChallengeItem> list, String filterName) {
    return list.where((item) => item.chName == filterName).toList();
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------
abstract class ChallengeEvent extends Equatable {
  const ChallengeEvent();

  @override
  List<Object> get props => [];
}

class GetChallengeDetail extends ChallengeEvent {
  final ChallengeDetailRequest request;

  const GetChallengeDetail({required this.request});

  @override
  List<Object> get props => [request];
}

class StartStopChallenge extends ChallengeEvent {
  final ChallengeStartStopRequest request;

  const StartStopChallenge({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class ChallengeState extends Equatable {
  const ChallengeState();

  @override
  List<Object> get props => [];
}

class ChallengeRefresh extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeErrorState extends ChallengeState {
  final String message;

  const ChallengeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class GetChallengeDetailSuccess extends ChallengeState {
  final Challenge challenge;

  const GetChallengeDetailSuccess({required this.challenge});

  @override
  List<Object> get props => [challenge];
}

class GetChallengeDetailFailed extends ChallengeState {
  final String message;

  const GetChallengeDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class ChallengeStartedState extends ChallengeState {}

class ChallengeStoppedState extends ChallengeState {}
