import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';

/// Domain event fed into the gamification rules engine.
///
/// Callers must ensure [id] is stable so retries can be de-duplicated upstream.
final class GamificationEvent {
  const GamificationEvent({
    required this.id,
    required this.type,
    required this.createdAt,
    this.metadata = const {},
  });

  final String id;
  final GamificationEventType type;
  final DateTime createdAt;
  final Map<String, Object?> metadata;
}
