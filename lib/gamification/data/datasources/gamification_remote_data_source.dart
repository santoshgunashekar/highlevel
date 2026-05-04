import 'package:highlevel/gamification/domain/model/gamification_action_status_update.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_page.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/model/sync_gamification_events_result.dart';

/// Contract for the gamification HTTP client (JSON mapped to domain elsewhere).
///
/// Implementations live under [data/datasources/]; the repository composes
/// remote responses with local/offline state.
abstract interface class GamificationRemoteDataSource {
  Future<GamificationDashboard> fetchDashboard(String userId);

  Future<LeaderboardPage> fetchLeaderboardPage({
    required LeaderboardScope scope,
    String? scopeId,
    required int page,
    required int pageSize,
    required String viewerUserId,
    required String viewerDisplayName,
    required int viewerXpForRanking,
  });

  Future<void> acknowledgeEventRecorded({
    required String userId,
    required GamificationEvent event,
  });

  Future<SyncGamificationEventsResult> syncPendingEvents({
    required GamificationDashboard localDashboard,
  });

  Future<void> notifyActionStatus(GamificationActionStatusUpdate update);
}
