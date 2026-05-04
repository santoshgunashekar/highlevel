import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';

sealed class GamificationDashboardState {
  const GamificationDashboardState();
}

final class GamificationDashboardInitial extends GamificationDashboardState {
  const GamificationDashboardInitial();
}

final class GamificationDashboardLoading extends GamificationDashboardState {
  const GamificationDashboardLoading();
}

final class GamificationDashboardReady extends GamificationDashboardState {
  const GamificationDashboardReady({
    required this.dashboard,
    this.lastRecordWasDuplicate = false,
  });

  final GamificationDashboard dashboard;
  final bool lastRecordWasDuplicate;
}

final class GamificationDashboardFailure extends GamificationDashboardState {
  const GamificationDashboardFailure(this.error);

  final Object error;
}
