import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiwalk_app/core/utils/logger.dart';
import 'package:wiwalk_app/modules/auth/auth_bloc.dart';

class Blocs {
  static final authBloc = AuthBloc();

  static void dispose() {
    authBloc.close();
  }
}

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i(error);
    super.onError(bloc, error, stackTrace);
  }
}
