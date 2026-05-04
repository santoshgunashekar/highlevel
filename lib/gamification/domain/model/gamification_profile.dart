/// User gamification snapshot (PRD `GamificationProfile`).
final class GamificationProfile {
  const GamificationProfile({
    required this.userId,
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.currentStreak,
    required this.bestStreak,
    required this.streakFreezeCount,
  });

  final String userId;
  final int level;
  final int currentXp;
  final int nextLevelXp;
  final int currentStreak;
  final int bestStreak;
  final int streakFreezeCount;

  GamificationProfile copyWith({
    String? userId,
    int? level,
    int? currentXp,
    int? nextLevelXp,
    int? currentStreak,
    int? bestStreak,
    int? streakFreezeCount,
  }) {
    return GamificationProfile(
      userId: userId ?? this.userId,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      nextLevelXp: nextLevelXp ?? this.nextLevelXp,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      streakFreezeCount: streakFreezeCount ?? this.streakFreezeCount,
    );
  }
}
