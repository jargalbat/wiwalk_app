import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/widgets/buttons/button_settings.dart';
import 'package:wiwalk_app/widgets/buttons/primary_button.dart';
import 'timer_bloc.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (state is TimerRunInProgress) {
          return Container(
            height: MButtonSize.mediumHeight,
            width: 61.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.primaryLight,
              borderRadius: BorderRadius.circular(CSize.buttonBorderRadius8),
            ),
            child: Text(
              formatTime(state.duration),
              style: context.textStyles.body14?.copyWith(
                fontSize: 15.0,
                color: context.theme.primaryColor,
              ),
            ),
          );
        } else if (state is TimerRunComplete) {
          return Center(
            child: PrimaryButton(
              settings: ButtonSettings.medium,
              onPressed: () =>
                  BlocProvider.of<TimerBloc>(context).add(TimerStarted()),
              width: 175.0,
              backgroundColor: context.colors.primaryLight,
              textStyle: context.textStyles.body14?.copyWith(
                fontSize: 15.0,
                color: context.theme.primaryColor,
              ),
              text: 'Дахин илгээх',
            ),
          );
        }

        return Container();
      },
    );
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    final String formattedMinutes = minutes.toString().padLeft(2, '0');
    final String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }
}
