import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/bloc/refresh_bloc.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/router/custom_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/assets.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/data/models/group_challenge.dart';
import 'package:wiwalk_app/widgets/cards/stroke_card.dart';
import 'package:wiwalk_app/widgets/text/section_title.dart';

import 'challenge_today_bloc.dart';

class ChallengeToday extends StatelessWidget {
  const ChallengeToday({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChallengeTodayBloc(),
      child: ChallengeTodayBody(margin: margin),
    );
  }
}

class ChallengeTodayBody extends StatefulWidget {
  const ChallengeTodayBody({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  State<ChallengeTodayBody> createState() => _ChallengeTodayBodyState();
}

class _ChallengeTodayBodyState extends State<ChallengeTodayBody> {
  // State
  ChallengeTodayBloc get _challengeTodayBloc =>
      context.read<ChallengeTodayBloc>();

  // UI
  final _height = 210.0;

  // Data
  GroupChallenge? _groupChallenge;

  @override
  void initState() {
    _challengeTodayBloc.add(GetChallengeOfTodayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChallengeTodayBloc, ChallengeTodayState>(
          listener: _challengeTodayListener,
        ),
        BlocListener<RefreshBloc, RefreshState>(
          listener: _refreshListener,
        ),
      ],
      child: BlocBuilder<ChallengeTodayBloc, ChallengeTodayState>(
        builder: (BuildContext context, ChallengeTodayState state) {
          if (_visible(state)) {
            return Container(
              margin: widget.margin,
              child: Column(
                children: [
                  /// Title
                  const SectionTitle(title: 'Өнөөдрийн чэлленж'),

                  const SizedBox(height: CSize.spacing20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Progress widget
                      _progressWidget(),

                      const SizedBox(width: CSize.spacing8),

                      /// Challenges
                      Expanded(
                        child: Column(
                          children: [
                            // if(_groupChallenge?.challenges != null)
                            //   for(var el in _groupChallenge!.challenges!)
                            //     _challenge(el),

                            _challenge(_groupChallenge!.challenges![0]),

                            const SizedBox(height: CSize.spacing8),

                            _challenge(_groupChallenge!.challenges![1]),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _refreshListener(BuildContext context, RefreshState state) {
    if (state is RefreshChallengeTodayState) {
      _challengeTodayBloc.add(GetChallengeOfTodayEvent());
    }
  }

  void _challengeTodayListener(
      BuildContext context, ChallengeTodayState state) {
    if (state is GetChallengeTodaySuccess) {
      _groupChallenge = state.groupChallenge;
    }
  }

  bool _visible(ChallengeTodayState state) {
    return _groupChallenge != null || state is ChallengeTodayLoadingState;
  }

  Widget _progressWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CSize.cardBorderRadius8),
      child: Container(
        width: 110.0,
        height: _height,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Image.asset(
                Assets.fluencyCave,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: CSize.spacing20,
                horizontal: CSize.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Flag
                  Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        CSize.cardBorderRadius8,
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.flag,
                      fit: BoxFit.scaleDown,
                    ),
                  ),

                  const SizedBox(height: CSize.spacing24),

                  /// Биелэлт
                  Text(
                    'Биелэлт',
                    style: context.textStyles.body14?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.text5,
                    ),
                  ),

                  const SizedBox(height: CSize.spacing8),

                  /// Хувь
                  Text(
                    '${_groupChallenge?.progress}%',
                    style: context.textStyles.body14?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                      color: context.colors.text5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _challenge(ChallengeOld challenge) {
    return StrokeCard(
      onTap: () {
        router.pushNamed(RouteNames.challenge);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: CSize.spacing20,
          horizontal: CSize.spacing16,
        ),
        height: 96.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              challenge.title ?? '',
              style: context.textStyles.body14?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.text2,
              ),
            ),

            /// Title
            Row(
              children: [
                Text(
                  '${challenge.progress}',
                  style: context.textStyles.heading20?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '/${challenge.target}',
                  style: context.textStyles.heading20?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colors.text4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
