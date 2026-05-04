import 'package:highlevel/gamification/domain/model/gamification_action_status_update.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

/// PRD-style “notify action status” (badge viewed, milestone shared, etc.).
final class NotifyGamificationActionStatusUseCase {
  const NotifyGamificationActionStatusUseCase(this._repository);

  final GamificationRepository _repository;

  Future<void> call(GamificationActionStatusUpdate update) {
    if (update.userId.isEmpty) {
      throw ArgumentError.value(update.userId, 'update.userId', 'Must not be empty');
    }
    if (update.actionKey.isEmpty) {
      throw ArgumentError.value(update.actionKey, 'update.actionKey', 'Must not be empty');
    }
    return _repository.notifyActionStatus(update);
  }
}
