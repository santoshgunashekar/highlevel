import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';

sealed class GamificationDashboardEvent {
  const GamificationDashboardEvent();
}

final class GamificationDashboardLoadRequested extends GamificationDashboardEvent {
  const GamificationDashboardLoadRequested();
}

final class GamificationDashboardMockEventTriggered extends GamificationDashboardEvent {
  const GamificationDashboardMockEventTriggered(this.type);

  final GamificationEventType type;
}
