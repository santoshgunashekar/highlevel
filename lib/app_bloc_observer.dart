import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Logs bloc lifecycle and transitions in debug builds only.
final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[Bloc] $message');
    }
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _log('created ${bloc.runtimeType}');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _log(
      '${bloc.runtimeType} | ${transition.event} '
      '(${transition.currentState} → ${transition.nextState})',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('[Bloc] ${bloc.runtimeType} error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _log('closed ${bloc.runtimeType}');
  }
}
