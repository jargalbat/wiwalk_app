import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';
import 'package:wiwalk_app/modules/auth/auth_bloc.dart';
import 'package:wiwalk_app/modules/auth/forgot_password/forgot_password_screen.dart';
import 'package:wiwalk_app/modules/auth/login/login_screen.dart';
import 'package:wiwalk_app/modules/auth/sign_up/dan_auth_screen.dart';
import 'package:wiwalk_app/modules/auth/sign_up/sign_up_screen.dart';
import 'package:wiwalk_app/modules/challenge/challenge_detail_screen/challenge_detail_screen.dart';
import 'package:wiwalk_app/modules/challenge/challenge_screen/challenge_screen.dart';
import 'package:wiwalk_app/modules/home/home_screen.dart';
import 'package:wiwalk_app/modules/onboarding/onboarding_screen.dart';
import 'package:wiwalk_app/modules/profile/profile_screen.dart';
import 'route_names.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: false,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) {
        // if (kDebugMode) sharedPref.clear();

        if (sharedPref.getBool(SharedPrefKeys.showIntro) ?? true) {
          // Onboarding
          sharedPref.setBool(SharedPrefKeys.showIntro, false);
          return state.namedLocation(RouteNames.onboarding);
        } else if (!context.read<AuthBloc>().isLoggedIn) {
          // Login
          return state.namedLocation(RouteNames.login);
        } else {
          // Home
          return state.namedLocation(RouteNames.home);
        }
      },
    ),
    GoRoute(
      name: RouteNames.onboarding,
      path: '/${RouteNames.onboarding}',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      name: RouteNames.login,
      path: '/${RouteNames.login}',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: RouteNames.forgotPassword,
          path: RouteNames.forgotPassword,
          builder: (BuildContext context, GoRouterState state) {
            return const ForgotPasswordScreen();
          },
        ),
        GoRoute(
          name: RouteNames.signUp,
          path: RouteNames.signUp,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
      ],
    ),
    GoRoute(
      name: RouteNames.danAuth,
      path: '/${RouteNames.danAuth}',
      builder: (BuildContext context, GoRouterState state) {
        return const DanAuthScreen();
      },
    ),
    GoRoute(
      name: RouteNames.home,
      path: '/${RouteNames.home}',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: RouteNames.challengeDetail,
          path: RouteNames.challengeDetail,
          builder: (BuildContext context, GoRouterState state) {
            return const ChallengeDetailScreen();
          },
        ),
        GoRoute(
          name: RouteNames.challenge,
          path: RouteNames.challenge,
          builder: (BuildContext context, GoRouterState state) {
            return const ChallengeScreen();
          },
        ),
        GoRoute(
          name: RouteNames.profile,
          path: RouteNames.profile,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen();
          },
        ),
      ],
    ),
  ],
);
