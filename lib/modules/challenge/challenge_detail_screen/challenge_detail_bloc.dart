import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/c_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/data/models/group_challenge.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class ChallengeDetailBloc
    extends Bloc<ChallengeDetailEvent, ChallengeDetailState> {
  ChallengeDetailBloc() : super(ChallengeDetailRefresh()) {
    on<GetChallengeDetail>((event, emit) async {
      try {
        emit(ChallengeDetailLoading());

        final response = await cClient.sendRequest(
          path: ApiPaths.challengeDetail,
          requestData: event.request.toJson(),
        );

        var cRes = ChallengeDetailResponse.fromJson(response.data);
        if (cRes.retType == 0 &&
            cRes.challenge != null &&
            (cRes.challengeDays?.isNotEmpty ?? false)) {
          emit(
            FetchedChallengeDetail(
              challenge: cRes.challenge!,
              challengeDays: cRes.challengeDays!,
            ),
          );
        } else {
          emit(
            FetchChallengeDetailFailed(
              message: CResponse.getMessage(cRes, 'Мэдээлэл олдсонгүй'),
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) print(e);
        emit(FetchChallengeDetailFailed(message: 'Алдаа гарлаа. $e'));
      }

      emit(ChallengeDetailRefresh());
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
abstract class ChallengeDetailEvent extends Equatable {
  const ChallengeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetChallengeDetail extends ChallengeDetailEvent {
  final ChallengeDetailRequest request;

  const GetChallengeDetail({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class ChallengeDetailState extends Equatable {
  const ChallengeDetailState();

  @override
  List<Object> get props => [];
}

class ChallengeDetailRefresh extends ChallengeDetailState {}

class ChallengeDetailLoading extends ChallengeDetailState {}

class FetchedChallengeDetail extends ChallengeDetailState {
  final Challenge challenge;
  final List<ChallengeDay> challengeDays;

  const FetchedChallengeDetail(
      {required this.challenge, required this.challengeDays});

  @override
  List<Object> get props => [challenge, challengeDays];
}

class FetchChallengeDetailFailed extends ChallengeDetailState {
  final String message;

  const FetchChallengeDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
