import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';

/// Result of accepting a [GamificationEvent] into the engine (local and/or remote).
final class GamificationEventRecordingResult {
  const GamificationEventRecordingResult({
    required this.dashboard,
    required this.wasDuplicate,
  });

  final GamificationDashboard dashboard;
  final bool wasDuplicate;
}
