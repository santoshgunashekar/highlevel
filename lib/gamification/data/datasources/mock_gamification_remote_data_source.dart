import 'dart:math' as math;

import 'package:highlevel/gamification/data/datasources/gamification_remote_data_source.dart';
import 'package:highlevel/gamification/domain/gamification_dashboard_event_applier.dart';
import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/badge_category.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_action_status_update.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_entry.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_page.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_rank_change.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/model/sync_gamification_events_result.dart';

/// Deterministic in-memory stand-in for the gamification REST API.
final class MockGamificationRemoteDataSource implements GamificationRemoteDataSource {
  MockGamificationRemoteDataSource({
    this.artificialLatency = Duration.zero,
  });

  /// Simulated RTT for every call (set non-zero to exercise loading states).
  final Duration artificialLatency;

  static const _npcUserIds = <String>[
    'usr-ava-01',
    'usr-ben-02',
    'usr-chloe-03',
    'usr-diego-04',
    'usr-elena-05',
    'usr-finn-06',
    'usr-grace-07',
    'usr-hugo-08',
    'usr-ina-09',
    'usr-jon-10',
    'usr-kim-11',
    'usr-leo-12',
    'usr-mia-13',
    'usr-noah-14',
    'usr-ora-15',
    'usr-pia-16',
    'usr-raj-17',
    'usr-sara-18',
    'usr-tom-19',
    'usr-uma-20',
    'usr-vic-21',
    'usr-zoe-22',
  ];

  static const _npcNames = <String>[
    'Ava Chen',
    'Ben Ortiz',
    'Chloe Singh',
    'Diego Rossi',
    'Elena Novak',
    'Finn O\'Brien',
    'Grace Okonkwo',
    'Hugo Martins',
    'Ina Petrov',
    'Jon Dahl',
    'Kim Adebayo',
    'Leo Yamamoto',
    'Mia Kowalski',
    'Noah Fischer',
    'Ora Mensah',
    'Pia Lindqvist',
    'Raj Kapoor',
    'Sara Haddad',
    'Tom Nielsen',
    'Uma Desai',
    'Vic Tanaka',
    'Zoe Murphy',
  ];

  /// Baseline dashboard returned by [fetchDashboard] (matches repository seed).
  static GamificationDashboard baselineDashboard(String userId) {
    return GamificationDashboard(
      profile: GamificationProfile(
        userId: userId,
        level: 1,
        currentXp: 0,
        nextLevelXp: 100,
        currentStreak: 0,
        bestStreak: 0,
        streakFreezeCount: 0,
      ),
      badges: const [
        Badge(
          id: GamificationDashboardEventApplier.quickLearnerBadgeId,
          title: 'Quick learner',
          category: BadgeCategory.learning,
          progress: 0,
          isUnlocked: false,
          rewardXp: 20,
        ),
        Badge(
          id: GamificationDashboardEventApplier.communityHelperBadgeId,
          title: 'Community helper',
          category: BadgeCategory.community,
          progress: 0,
          isUnlocked: false,
          rewardXp: 25,
        ),
      ],
      challenges: const [
        Challenge(
          id: GamificationDashboardEventApplier.weeklyTasksChallengeId,
          title: 'Weekly tasks',
          description: 'Complete tasks this week.',
          progress: 0,
          target: 5,
          rewardXp: 40,
          isCompleted: false,
        ),
      ],
    );
  }

  Future<void> _delay() async {
    if (artificialLatency > Duration.zero) {
      await Future<void>.delayed(artificialLatency);
    }
  }

  int _scopeSalt(LeaderboardScope scope, String? scopeId) {
    switch (scope) {
      case LeaderboardScope.global:
        return 0;
      case LeaderboardScope.team:
        return 37 + (scopeId?.hashCode ?? 0).abs() % 180;
      case LeaderboardScope.project:
        return 91 + (scopeId?.hashCode ?? 0).abs() % 260;
    }
  }

  int _npcBaseXp(int index, int scopeSalt) {
    final spread = 420 + index * 640 + (index * index * 13) % 400;
    return spread + scopeSalt;
  }

  LeaderboardRankChange _rankTrend(int seed) {
    return LeaderboardRankChange.values[seed.abs() % LeaderboardRankChange.values.length];
  }

  @override
  Future<GamificationDashboard> fetchDashboard(String userId) async {
    await _delay();
    return baselineDashboard(userId);
  }

  @override
  Future<LeaderboardPage> fetchLeaderboardPage({
    required LeaderboardScope scope,
    String? scopeId,
    required int page,
    required int pageSize,
    required String viewerUserId,
    required String viewerDisplayName,
    required int viewerXpForRanking,
  }) async {
    await _delay();
    if (page < 0 || pageSize <= 0) {
      return const LeaderboardPage(entries: [], hasNextPage: false);
    }

    final salt = _scopeSalt(scope, scopeId);
    final npcRows = <({String id, String name, int xp})>[];
    for (var i = 0; i < _npcUserIds.length; i++) {
      npcRows.add(
        (
          id: _npcUserIds[i],
          name: _npcNames[i],
          xp: _npcBaseXp(i, salt),
        ),
      );
    }

    final all = <({String id, String name, int xp, bool isViewer})>[
      ...npcRows.map((r) => (id: r.id, name: r.name, xp: r.xp, isViewer: false)),
      (
        id: viewerUserId,
        name: viewerDisplayName,
        xp: math.max(0, viewerXpForRanking),
        isViewer: true,
      ),
    ]..sort((a, b) {
        final byXp = b.xp.compareTo(a.xp);
        if (byXp != 0) {
          return byXp;
        }
        return a.id.compareTo(b.id);
      });

    final entries = <LeaderboardEntry>[];
    for (var i = 0; i < all.length; i++) {
      final row = all[i];
      final rank = i + 1;
      final img = (row.id.hashCode.abs() % 70) + 1;
      entries.add(
        LeaderboardEntry(
          userId: row.id,
          userName: row.name,
          avatarUrl: 'https://i.pravatar.cc/128?img=$img',
          rank: rank,
          xp: row.xp,
          change: row.isViewer
              ? LeaderboardRankChange.same
              : _rankTrend(rank * 17 + salt + page * 3),
        ),
      );
    }

    final start = page * pageSize;
    if (start >= entries.length) {
      return LeaderboardPage(
        entries: const [],
        hasNextPage: false,
      );
    }

    final end = math.min(start + pageSize, entries.length);
    final slice = entries.sublist(start, end);
    final hasNextPage = end < entries.length;

    return LeaderboardPage(
      entries: slice,
      hasNextPage: hasNextPage,
    );
  }

  @override
  Future<void> acknowledgeEventRecorded({
    required String userId,
    required GamificationEvent event,
  }) async {
    await _delay();
  }

  @override
  Future<SyncGamificationEventsResult> syncPendingEvents({
    required GamificationDashboard localDashboard,
  }) async {
    await _delay();
    return SyncGamificationEventsResult(
      appliedCount: 0,
      duplicateSkippedCount: 0,
      dashboard: localDashboard,
    );
  }

  @override
  Future<void> notifyActionStatus(GamificationActionStatusUpdate update) async {
    await _delay();
  }
}
