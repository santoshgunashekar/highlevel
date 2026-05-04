import 'package:highlevel/gamification/domain/model/gamification_action_status_update.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_recording_result.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_page.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/model/sync_gamification_events_result.dart';

abstract interface class GamificationRepository {
  Future<GamificationDashboard> loadDashboard(String userId);

  Future<LeaderboardPage> fetchLeaderboardPage({
    required LeaderboardScope scope,
    String? scopeId,
    required int page,
    required int pageSize,
  });

  Future<GamificationEventRecordingResult> recordEvent({
    required String userId,
    required GamificationEvent event,
    GamificationDashboard? optimisticDashboard,
  });

  Future<SyncGamificationEventsResult> syncPendingEvents();

  Future<void> notifyActionStatus(GamificationActionStatusUpdate update);
}
