import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:highlevel/app_bloc_observer.dart';
import 'package:highlevel/gamification/gamification_di.dart';
import 'package:highlevel/gamification/presentation/ui/gamification_dashboard_page.dart';
import 'package:highlevel/init.dart';
import 'package:highlevel/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await configureDependencies();
  await GamificationDi.initialize();
  runApp(const HighlevelApp());
}

final class HighlevelApp extends StatelessWidget {
  const HighlevelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const GamificationDashboardPage(),
      },
    );
  }
}
