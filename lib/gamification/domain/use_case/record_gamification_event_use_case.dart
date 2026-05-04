import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_recording_result.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

final class RecordGamificationEventUseCase {
  const RecordGamificationEventUseCase(this._repository);

  final GamificationRepository _repository;

  Future<GamificationEventRecordingResult> call({
    required String userId,
    required GamificationEvent event,
    GamificationDashboard? optimisticDashboard,
  }) {
    if (event.id.isEmpty) {
      throw ArgumentError.value(event.id, 'event.id', 'Event id must not be empty');
    }
    if (userId.isEmpty) {
      throw ArgumentError.value(userId, 'userId', 'Must not be empty');
    }
    return _repository.recordEvent(
      userId: userId,
      event: event,
      optimisticDashboard: optimisticDashboard,
    );
  }
}
