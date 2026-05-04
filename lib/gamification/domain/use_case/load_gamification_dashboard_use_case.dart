import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

final class LoadGamificationDashboardUseCase {
  const LoadGamificationDashboardUseCase(this._repository);

  final GamificationRepository _repository;

  Future<GamificationDashboard> call(String userId) {
    return _repository.loadDashboard(userId);
  }
}
