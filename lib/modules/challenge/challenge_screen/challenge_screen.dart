import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_detail_response.dart';
import 'package:wiwalk_app/data/models/challenge/challenge_startstop_request.dart';
import 'package:wiwalk_app/modules/challenge/challenge_helper.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/challenge_bloc.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/widgets/doughnut_chart.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  // State
  ChallengeBloc get _challengeBloc => context.read<ChallengeBloc>();

  bool _isChallengeStarted = false;

  // Data
  Challenge? _challenge;

  @override
  void initState() {
    super.initState();

    data = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    tooltip = TooltipBehavior(enable: true);

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: _listener,
      child: BlocBuilder<ChallengeBloc, ChallengeState>(
        builder: (BuildContext context, ChallengeState state) {
          return CScaffold(
            title: _challenge?.chName ?? '',
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _circleChart(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Алхалт
                      Expanded(
                        child: _card(
                          bgColor: context.theme.primaryColor,
                          text1: 'Алхалт хийх',
                          text2: '${Func.toInt(_challenge?.measureValue)}'
                              '${ChallengeHelper.getMeasureTypeName(_challenge?.measureType)}',
                        ),
                      ),

                      SizedBox(width: CSize.spacing8),

                      // Бичлэг үзэх
                      Expanded(
                        child: _card(
                          bgColor: Color(0xFFFF934E),
                          text1: 'Бичлэг үзэх',
                          text2: '${Func.toInt(_challenge?.promocount)} бичлэг',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: CSize.spacing24),
                ],
              ),
            ),
            floatingActionButton: Container(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  final request = ChallengeStartStopRequest(
                    challengeId: widget.challengeId,
                    isStart: _isChallengeStarted ? 1 : 0,
                  );

                  _challengeBloc.add(StartStopChallenge(request: request));
                },
                child: Icon(
                  _isChallengeStarted ? Icons.play_arrow : Icons.pause,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _listener(BuildContext context, ChallengeState state) {
    if (state is GetChallengeDetailSuccess) {
      _challenge = state.challenge;
    } else if (state is GetChallengeDetailFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        text: state.message,
        button2Text: 'Ok',
      );
    } else if (state is ChallengeStartedState) {
      _isChallengeStarted = true;
    } else if (state is ChallengeStoppedState) {
      _isChallengeStarted = false;
    }
  }

  void _getData() {
    var request = ChallengeDetailRequest(
      challengeId: widget.challengeId,
      repDate: DateTime.now().toString(),
    );

    _challengeBloc.add(GetChallengeDetail(request: request));
  }

  late List<ChartData> data;
  late TooltipBehavior tooltip;

  Widget _circleChart() {
    return Container(
      child: Row(
        children: [
          Expanded(child: DoughnutChart(data: data, tooltip: tooltip)),
          // Expanded(child: child),
        ],
      ),
    );
  }

  Widget _card({Color? bgColor, String? text1, String? text2}) {
    return Container(
      padding: EdgeInsets.all(CSize.spacing16),
      decoration: BoxDecoration(
        color: bgColor ?? context.theme.primaryColor,
        borderRadius: BorderRadius.circular(CSize.cardBorderRadius8),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1 ?? '',
            style: context.textStyles.body12?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            text2 ?? '',
            style: context.textStyles.heading16?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
