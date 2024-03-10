import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/api/c_client.dart';
import 'package:wiwalk_app/data/models/c_request.dart';
import 'package:wiwalk_app/data/models/c_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------
class ChallengeDashboardBloc
    extends Bloc<ChallengeDashboardEvent, ChallengeDashboardState> {
  ChallengeDashboardBloc() : super(ChallengeDashboardRefresh()) {
    on<FetchChallengesEvent>((event, emit) async {
      try {
        emit(ChallengeDashboardLoadingState());

        final response = await cClient.sendRequest(
          path: ApiPaths.challengeList,
          requestData: event.request.toJson(),
        );

        ChallengesResponse cRes = ChallengesResponse.fromJson(response.data);
        if (cRes.retType == 0 && (cRes.challenges?.isNotEmpty ?? false)) {
          emit(
            FetchedChallenges(
              mainChallenges:
                  cRes.challenges?.where((item) => item.isMain == 1).toList(),
              otherChallenges:
                  cRes.challenges?.where((item) => item.isMain == 0).toList(),
              filters: cRes.filters,
            ),
          );
        } else {
          emit(
            FetchChallengesFailed(
              message: CResponse.getMessage(cRes, 'Мэдээлэл олдсонгүй'),
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) print(e);
        emit(FetchChallengesFailed(message: 'Алдаа гарлаа. $e'));
      }

      emit(ChallengeDashboardRefresh());
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
abstract class ChallengeDashboardEvent extends Equatable {
  const ChallengeDashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchChallengesEvent extends ChallengeDashboardEvent {
  final CRequest request;

  const FetchChallengesEvent({required this.request});

  @override
  List<Object> get props => [request];
}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------
abstract class ChallengeDashboardState extends Equatable {
  const ChallengeDashboardState();

  @override
  List<Object> get props => [];
}

class ChallengeDashboardRefresh extends ChallengeDashboardState {}

class ChallengeDashboardLoadingState extends ChallengeDashboardState {}

class FetchedChallenges extends ChallengeDashboardState {
  final List<ChallengeItem>? mainChallenges;
  final List<ChallengeItem>? otherChallenges;
  final List<ChallengeFilter>? filters;

  const FetchedChallenges({
    this.mainChallenges,
    this.otherChallenges,
    this.filters,
  });

  @override
  List<Object> get props => [
        mainChallenges ?? [],
        otherChallenges ?? [],
        filters ?? [],
      ];
}

class FetchChallengesFailed extends ChallengeDashboardState {
  final String message;

  const FetchChallengesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
