import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiwalk_app/core/extensions/context_extensions.dart';
import 'package:wiwalk_app/core/theme/c_size.dart';
import 'package:wiwalk_app/core/theme/theme_cubit.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  ThemeMode get _themeMode =>
      (sharedPref.getString(SharedPrefKeys.themeMode) ??
                  ThemeMode.light.name) ==
              ThemeMode.light.name
          ? ThemeMode.light
          : ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Theme'),
        const SizedBox(height: CSize.spacing20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Light theme
            Column(
              children: [
                Text('Light', style: context.textStyles.body12),
                Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: _themeMode,
                  onChanged: (ThemeMode? value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                )
              ],
            ),

            /// Dark theme
            Column(
              children: [
                Text('Dark', style: context.textStyles.body12),
                Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: _themeMode,
                  onChanged: (ThemeMode? value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
