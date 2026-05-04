/// Lightweight “action status” ping for analytics, remote badges, or server-side rules.
///
/// Keeps the domain contract generic; concrete keys live with product or data layer.
final class GamificationActionStatusUpdate {
  const GamificationActionStatusUpdate({
    required this.userId,
    required this.actionKey,
    this.payload = const {},
  });

  final String userId;
  final String actionKey;
  final Map<String, Object?> payload;
}
