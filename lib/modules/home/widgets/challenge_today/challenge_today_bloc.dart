import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/logger.dart';
import 'package:wiwalk_app/data/models/group_challenge.dart';

/// ----------------------------------------------------------------------------
/// BLOC
/// ----------------------------------------------------------------------------

class ChallengeTodayBloc
    extends Bloc<ChallengeTodayEvent, ChallengeTodayState> {
  ChallengeTodayBloc() : super(ChallengeTodayInitState()) {
    on<GetChallengeOfTodayEvent>((event, emit) async {
      try {
        emit(ChallengeTodayLoadingState());

        var challengeGroup = _getTestChallengeGroup();
        if (challengeGroup != null) {
          // Success
          emit(GetChallengeTodaySuccess(challengeGroup));
        }
      } catch (e) {
        logger.f(e);
        // emit(const ChallengeShowToast(message: 'Алдаа гарлаа'));
      }

      emit(ChallengeTodayInitState());
    });
  }

  static GroupChallenge? _getTestChallengeGroup() {
    return GroupChallenge(
      id: "testId",
      progress: 45,
      challenges: [
        Challenge(
          id: "challenge1",
          title: "Алхалт",
          type: "walk",
          unit: "km",
          progress: 0.1,
          target: 5,
        ),
        Challenge(
          id: "challenge2",
          title: "Бичлэг",
          type: "promotion",
          unit: "count",
          progress: 1,
          target: 2,
          promotions: [
            Promotion(
              id: "videoId",
              type: "video",
              title: "Видео",
              description: "Дэлгэрэнгүй тайлбар",
              url:
                  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
            ),
            Promotion(
              id: "imageId",
              type: "image",
              title: "Зураг",
              description: "Дэлгэрэнгүй тайлбар",
              url: "https://picsum.photos/400/800",
            ),
          ],
        ),
      ],
    );
  }
}

/// ----------------------------------------------------------------------------
/// BLOC EVENTS
/// ----------------------------------------------------------------------------

abstract class ChallengeTodayEvent extends Equatable {
  const ChallengeTodayEvent();

  @override
  List<Object> get props => [];
}

class GetChallengeOfTodayEvent extends ChallengeTodayEvent {}

/// ----------------------------------------------------------------------------
/// BLOC STATES
/// ----------------------------------------------------------------------------

abstract class ChallengeTodayState extends Equatable {
  const ChallengeTodayState();

  @override
  List<Object> get props => [];
}

class ChallengeTodayInitState extends ChallengeTodayState {}

class ChallengeTodayLoadingState extends ChallengeTodayState {}

class GetChallengeTodaySuccess extends ChallengeTodayState {
  final GroupChallenge groupChallenge;

  const GetChallengeTodaySuccess(this.groupChallenge);

  @override
  List<Object> get props => [groupChallenge];
}

// class GetChallengeTodayFailed extends ChallengeTodayState {
//   final String? message;
//
//   const GetChallengeTodayFailed({this.message});
//
//   @override
//   List<Object> get props => [message ?? ''];
// }
