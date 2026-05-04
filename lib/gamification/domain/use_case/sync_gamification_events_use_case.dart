import 'package:highlevel/gamification/domain/model/sync_gamification_events_result.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

final class SyncGamificationEventsUseCase {
  const SyncGamificationEventsUseCase(this._repository);

  final GamificationRepository _repository;

  Future<SyncGamificationEventsResult> call() {
    return _repository.syncPendingEvents();
  }
}
