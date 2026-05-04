import 'dart:collection';

import 'package:highlevel/gamification/data/datasources/gamification_remote_data_source.dart';
import 'package:highlevel/gamification/data/datasources/mock_gamification_remote_data_source.dart';
import 'package:highlevel/gamification/domain/gamification_dashboard_event_applier.dart';
import 'package:highlevel/gamification/domain/model/gamification_action_status_update.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_recording_result.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_page.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/model/sync_gamification_events_result.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

/// In-memory dashboard with domain rules; remote calls are mocked for latency/API parity.
final class MockGamificationRepository implements GamificationRepository {
  MockGamificationRepository({
    required GamificationRemoteDataSource remoteDataSource,
    required GamificationDashboardEventApplier dashboardEventApplier,
    required String demoUserId,
  })  : _remoteDataSource = remoteDataSource,
        _dashboardEventApplier = dashboardEventApplier,
        _demoUserId = demoUserId {
    _dashboard = MockGamificationRemoteDataSource.baselineDashboard(_demoUserId);
  }

  final GamificationRemoteDataSource _remoteDataSource;
  final GamificationDashboardEventApplier _dashboardEventApplier;
  final String _demoUserId;

  late GamificationDashboard _dashboard;
  final HashSet<String> _processedEventIds = HashSet();

  static int _viewerXpForLeaderboard(GamificationProfile profile) {
    return profile.level * 1000 + profile.currentXp;
  }

  @override
  Future<GamificationDashboard> loadDashboard(String userId) async {
    await _remoteDataSource.fetchDashboard(userId);
    return _dashboard;
  }

  @override
  Future<LeaderboardPage> fetchLeaderboardPage({
    required LeaderboardScope scope,
    String? scopeId,
    required int page,
    required int pageSize,
  }) async {
    return _remoteDataSource.fetchLeaderboardPage(
      scope: scope,
      scopeId: scopeId,
      page: page,
      pageSize: pageSize,
      viewerUserId: _demoUserId,
      viewerDisplayName: 'You',
      viewerXpForRanking: _viewerXpForLeaderboard(_dashboard.profile),
    );
  }

  @override
  Future<GamificationEventRecordingResult> recordEvent({
    required String userId,
    required GamificationEvent event,
    GamificationDashboard? optimisticDashboard,
  }) async {
    if (_processedEventIds.contains(event.id)) {
      return GamificationEventRecordingResult(dashboard: _dashboard, wasDuplicate: true);
    }
    _processedEventIds.add(event.id);
    if (optimisticDashboard != null) {
      _dashboard = optimisticDashboard;
    } else {
      _dashboard = _dashboardEventApplier.apply(dashboard: _dashboard, event: event);
    }
    await _remoteDataSource.acknowledgeEventRecorded(userId: userId, event: event);
    return GamificationEventRecordingResult(dashboard: _dashboard, wasDuplicate: false);
  }

  @override
  Future<SyncGamificationEventsResult> syncPendingEvents() async {
    return _remoteDataSource.syncPendingEvents(localDashboard: _dashboard);
  }

  @override
  Future<void> notifyActionStatus(GamificationActionStatusUpdate update) async {
    await _remoteDataSource.notifyActionStatus(update);
  }
}
