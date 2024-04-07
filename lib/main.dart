import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiwalk_app/core/bloc/refresh_bloc.dart';
import 'package:wiwalk_app/core/router/custom_router.dart';
import 'package:wiwalk_app/core/theme/theme_cubit.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/challenge_bloc.dart';
import 'core/bloc/blocs.dart';
import 'modules/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init utils
  sharedPref = await SharedPreferences.getInstance();

  runApp(const WiwalkApp());
}

class WiwalkApp extends StatelessWidget {
  const WiwalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => RefreshBloc()),
        // BlocProvider(create: (_) => AuthBloc()),
        BlocProvider.value(value: Blocs.authBloc),
        BlocProvider(create: (_) => ChallengeBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (BuildContext context, ThemeMode themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeCubit.lightTheme,
            darkTheme: ThemeCubit.darkTheme,
            themeMode: themeMode,
            // builder: ,
            // routerDelegate: router.routerDelegate,
            // routeInformationParser: router.routeInformationParser,
          );
        },
      ),
    );
  }
}
