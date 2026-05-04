import 'package:get_it/get_it.dart';
import 'package:highlevel/gamification/data/datasources/gamification_remote_data_source.dart';
import 'package:highlevel/gamification/data/datasources/mock_gamification_remote_data_source.dart';
import 'package:highlevel/gamification/data/repository/mock_gamification_repository.dart';
import 'package:highlevel/gamification/domain/gamification_dashboard_event_applier.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';
import 'package:highlevel/gamification/domain/rules/default_gamification_event_rules.dart';
import 'package:highlevel/gamification/domain/rules/gamification_event_rule.dart';
import 'package:highlevel/gamification/domain/rules/gamification_leveling_policy.dart';
import 'package:highlevel/gamification/domain/rules/gamification_outcome_applier.dart';
import 'package:highlevel/gamification/domain/use_case/fetch_leaderboard_page_use_case.dart';
import 'package:highlevel/gamification/domain/use_case/load_gamification_dashboard_use_case.dart';
import 'package:highlevel/gamification/domain/use_case/record_gamification_event_use_case.dart';

abstract final class GamificationDi {
  static const demoUserId = 'demo-user';

  static Future<void> initialize() async {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<GamificationLevelingPolicy>(
      () => const StandardGamificationLevelingPolicy(),
    );
    getIt.registerLazySingleton<GamificationEventRuleRegistry>(
      createDefaultGamificationRuleRegistry,
    );
    getIt.registerLazySingleton(
      () => GamificationEventRuleEvaluator(getIt<GamificationEventRuleRegistry>()),
    );
    getIt.registerLazySingleton(
      () => GamificationOutcomeApplier(getIt<GamificationLevelingPolicy>()),
    );
    getIt.registerLazySingleton(
      () => GamificationDashboardEventApplier(
        ruleEvaluator: getIt(),
        outcomeApplier: getIt(),
      ),
    );
    getIt.registerLazySingleton<GamificationRemoteDataSource>(
      () => MockGamificationRemoteDataSource(),
    );
    getIt.registerLazySingleton<GamificationRepository>(
      () => MockGamificationRepository(
        remoteDataSource: getIt<GamificationRemoteDataSource>(),
        dashboardEventApplier: getIt(),
        demoUserId: demoUserId,
      ),
    );
    getIt.registerLazySingleton(
      () => LoadGamificationDashboardUseCase(getIt<GamificationRepository>()),
    );
    getIt.registerLazySingleton(
      () => RecordGamificationEventUseCase(getIt<GamificationRepository>()),
    );
    getIt.registerLazySingleton(
      () => FetchLeaderboardPageUseCase(getIt<GamificationRepository>()),
    );
  }
}
