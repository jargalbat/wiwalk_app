import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/router/route_names.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_response.dart';
import 'package:wiwalk_app/modules/challenge/challenge_dashboard/challenge_item_widget.dart';
import 'package:wiwalk_app/modules/challenge/challenge_dashboard/filter_button.dart';
import 'package:wiwalk_app/modules/challenge/challenge_helper.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/text/section_title.dart';
import 'challenge_detail_bloc.dart';

class ChallengeDetailScreen extends StatefulWidget {
  const ChallengeDetailScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
// State
  final _challengeDetailBloc = ChallengeDetailBloc();

  // Data
  Challenge? _challenge;
  List<ChallengeDay> _challengeDays = [];

  // UI
  final _horizontalMargin =
      const EdgeInsets.symmetric(horizontal: CSize.spacing24);

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: 'Чэлленж',
      body: BlocProvider(
        create: (context) => _challengeDetailBloc,
        child: BlocListener<ChallengeDetailBloc, ChallengeDetailState>(
          listener: _listener,
          child: BlocBuilder<ChallengeDetailBloc, ChallengeDetailState>(
            builder: (BuildContext context, ChallengeDetailState state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    SectionTitle(
                      title: 'Өнөөдрийн чэлленж',
                      margin: _horizontalMargin,
                    ),

                    const SizedBox(height: CSize.spacing24),

                    Container(
                      margin: _horizontalMargin,
                      child: Text(_challenge?.chName ?? ''),
                    ),

                    Container(
                      margin: _horizontalMargin,
                      child: Text('Desc'),
                    ),

                    Container(
                      margin: _horizontalMargin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ChallengeHelper.getChallengeTypeName(
                                _challenge?.chType),
                          ),
                          Text(
                            '${_challenge?.remainDateStr}',
                          ),
                          Text(
                            ChallengeHelper.getIsPublicName(
                                _challenge?.isPublic),
                          ),
                        ],
                      ),
                    ),

                    const Divider(),

                    SectionTitle(
                      title: 'Даалгавар',
                      margin: _horizontalMargin,
                    ),

                    const Text('Алхалт хийх'),
                    Text(
                      '${Func.toInt(_challenge?.measureValue)}'
                      '${ChallengeHelper.getMeasureTypeName(_challenge?.measureType)}',
                    ),

                    const Text('Бичлэг үзэх'),
                    Text(
                      '${Func.toInt(_challenge?.measureValue)} бичлэг',
                    ),

                    SectionTitle(
                      title: 'Миний оролцоо',
                      margin: _horizontalMargin,
                    ),

                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var el in _challengeDays) challengeDayWidget(el),
                        ],
                      ),
                    ),

                    PrimaryButton(
                      settings: ButtonSettings.medium,
                      onPressed: () {
                        context.pushNamed(
                          RouteNames.challenge,
                          pathParameters: {'id': widget.challengeId},
                        );
                      },
                      text: 'Оролцох',
                    ),

                    const SizedBox(height: CSize.spacing24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ChallengeDetailState state) {
    if (state is FetchedChallengeDetail) {
      _challenge = state.challenge;
      _challengeDays = state.challengeDays;
    } else if (state is FetchChallengeDetailFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  void _getData() {
    var request = ChallengeDetailRequest(
      challengeId: widget.challengeId,
      repDate: DateTime.now().toString(),
    );

    _challengeDetailBloc.add(GetChallengeDetail(request: request));
  }

  Widget challengeDayWidget(ChallengeDay challengeDay) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Text(challengeDay.weekDay ?? ''),
          Text(Func.dayOfMonth(challengeDay.challDate)),
          Text('${challengeDay.dayPercent}'),
          Text('${challengeDay.stepPercent}'),
          Text('${challengeDay.promoPercent}'),
        ],
      ),
    );
  }
}
