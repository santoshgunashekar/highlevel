import 'package:highlevel/gamification/domain/model/badge_category.dart';

/// PRD `Badge` — progress toward unlock and XP granted on completion.
final class Badge {
  const Badge({
    required this.id,
    required this.title,
    required this.category,
    required this.progress,
    required this.isUnlocked,
    required this.rewardXp,
    this.unlockedAt,
  });

  final String id;
  final String title;
  final BadgeCategory category;
  final int progress;
  final bool isUnlocked;
  final int rewardXp;
  final DateTime? unlockedAt;

  Badge copyWith({
    String? id,
    String? title,
    BadgeCategory? category,
    int? progress,
    bool? isUnlocked,
    int? rewardXp,
    DateTime? unlockedAt,
  }) {
    return Badge(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      progress: progress ?? this.progress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      rewardXp: rewardXp ?? this.rewardXp,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}
