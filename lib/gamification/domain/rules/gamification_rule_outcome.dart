/// Effect applied to a single badge when processing an event outcome.
final class GamificationBadgeEffect {
  const GamificationBadgeEffect({
    required this.badgeId,
    required this.progressDelta,
    this.requestUnlock = false,
  });

  final String badgeId;
  final int progressDelta;
  final bool requestUnlock;
}

/// Effect applied to a single challenge when processing an event outcome.
final class GamificationChallengeEffect {
  const GamificationChallengeEffect({
    required this.challengeId,
    required this.progressDelta,
  });

  final String challengeId;
  final int progressDelta;
}

/// Aggregated mechanical result of evaluating rules for one [GamificationEvent].
final class GamificationRuleOutcome {
  const GamificationRuleOutcome({
    this.xpDelta = 0,
    this.streakDelta = 0,
    this.badgeEffects = const [],
    this.challengeEffects = const [],
  });

  final int xpDelta;
  final int streakDelta;
  final List<GamificationBadgeEffect> badgeEffects;
  final List<GamificationChallengeEffect> challengeEffects;
}
