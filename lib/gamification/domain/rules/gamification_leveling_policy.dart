import 'package:highlevel/gamification/domain/model/gamification_profile.dart';

abstract interface class GamificationLevelingPolicy {
  int xpToReachNextLevel(int level);

  GamificationProfile applyXpGain(GamificationProfile profile, int xpDelta);
}

final class StandardGamificationLevelingPolicy implements GamificationLevelingPolicy {
  const StandardGamificationLevelingPolicy();

  @override
  int xpToReachNextLevel(int level) {
    if (level < 1) {
      throw ArgumentError.value(level, 'level', 'Level must be >= 1');
    }
    return 100 * level;
  }

  @override
  GamificationProfile applyXpGain(GamificationProfile profile, int xpDelta) {
    if (xpDelta == 0) {
      return profile;
    }
    if (xpDelta < 0) {
      throw ArgumentError.value(xpDelta, 'xpDelta', 'XP delta must be non-negative');
    }

    var level = profile.level;
    var currentXp = profile.currentXp + xpDelta;
    var nextLevelXp = profile.nextLevelXp;

    if (nextLevelXp <= 0) {
      nextLevelXp = xpToReachNextLevel(level);
    }

    while (currentXp >= nextLevelXp) {
      currentXp -= nextLevelXp;
      level += 1;
      nextLevelXp = xpToReachNextLevel(level);
    }

    return profile.copyWith(
      level: level,
      currentXp: currentXp,
      nextLevelXp: nextLevelXp,
    );
  }
}
