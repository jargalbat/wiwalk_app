import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/data/models/c_request.dart';
import 'package:wiwalk_app/data/models/challenge/challenges_response.dart';
import 'package:wiwalk_app/modules/challenge/challenge_dashboard/chalenge_dashboard_bloc.dart';
import 'package:wiwalk_app/modules/challenge/challenge_dashboard/challenge_item_widget.dart';
import 'package:wiwalk_app/widgets/c_scaffold.dart';
import 'package:wiwalk_app/widgets/dialogs/custom_dialog.dart';
import 'package:wiwalk_app/widgets/text/section_title.dart';

import 'filter_button.dart';

class ChallengeDashboard extends StatefulWidget {
  const ChallengeDashboard({super.key});

  @override
  State<ChallengeDashboard> createState() => _ChallengeDashboardState();
}

class _ChallengeDashboardState extends State<ChallengeDashboard> {
// State
  final _challengeDashboardBloc = ChallengeDashboardBloc();

  // Data
  List<ChallengeItem> _mainChallenges = [];
  List<ChallengeItem> _otherChallenges = [];

  // Filter
  List<ChallengeFilter> _filters = [];
  ChallengeFilter? _selectedFilter;

  // UI
  final _horizontalMargin =
      const EdgeInsets.symmetric(horizontal: CSize.spacing24);

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (context) => _challengeDashboardBloc,
        child: BlocListener<ChallengeDashboardBloc, ChallengeDashboardState>(
          listener: _listener,
          child: BlocBuilder<ChallengeDashboardBloc, ChallengeDashboardState>(
            builder: (BuildContext context, ChallengeDashboardState state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: CSize.spacing24),

                    /// Title
                    SectionTitle(
                      title: 'Үндсэн чэлленж',
                      margin: _horizontalMargin,
                    ),

                    const SizedBox(height: CSize.spacing24),

                    for (var el in _mainChallenges)
                      ChallengeItemWidget(
                        challengeItem: el,
                        margin: _horizontalMargin,
                      ),

                    const SizedBox(height: CSize.spacing24),

                    SizedBox(
                      height: 42.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var el in _filters)
                            FilterButton(
                              label: el.name ?? '',
                              isSelected: el == _selectedFilter,
                              count: 10,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                            )
                        ],
                      ),
                    ),

                    SectionTitle(
                      title: 'Бусад чэлленж',
                      margin: _horizontalMargin,
                    ),

                    const SizedBox(height: CSize.spacing24),

                    for (var el in _otherChallenges)
                      ChallengeItemWidget(
                        challengeItem: el,
                        margin: _horizontalMargin,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, ChallengeDashboardState state) {
    if (state is FetchedChallenges) {
      _mainChallenges = state.mainChallenges ?? [];
      _otherChallenges = state.otherChallenges ?? [];
      _filters = state.filters ?? [];
      _selectedFilter = _filters.first;
    } else if (state is FetchChallengesFailed) {
      showCustomDialog(
        context,
        dialogType: DialogType.error,
        text: state.message,
        button2Text: 'Ok',
      );
    }
  }

  void _fetchData() {
    // todo jagaa paging
    var request = CRequest()
      ..pId = 0
      ..pSize = 100;

    _challengeDashboardBloc.add(FetchChallengesEvent(request: request));
  }
}
