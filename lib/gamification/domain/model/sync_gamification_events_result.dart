import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';

/// Result of flushing the offline event queue (replay + conflict handling in impl).
final class SyncGamificationEventsResult {
  const SyncGamificationEventsResult({
    required this.appliedCount,
    required this.duplicateSkippedCount,
    required this.dashboard,
  });

  final int appliedCount;
  final int duplicateSkippedCount;
  final GamificationDashboard dashboard;
}
