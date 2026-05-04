import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';
import 'package:highlevel/gamification/domain/rules/gamification_leveling_policy.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_outcome.dart';

final class GamificationOutcomeApplier {
  const GamificationOutcomeApplier(this._leveling);

  final GamificationLevelingPolicy _leveling;

  (GamificationProfile profile, List<Badge> badges, List<Challenge> challenges) apply({
    required GamificationProfile profile,
    required List<Badge> badges,
    required List<Challenge> challenges,
    required GamificationRuleOutcome outcome,
    required DateTime eventOccurredAt,
  }) {
    var nextProfile = _leveling.applyXpGain(profile, outcome.xpDelta);

    if (outcome.streakDelta != 0) {
      final streak = nextProfile.currentStreak + outcome.streakDelta;
      final best = streak > nextProfile.bestStreak ? streak : nextProfile.bestStreak;
      nextProfile = nextProfile.copyWith(
        currentStreak: streak < 0 ? 0 : streak,
        bestStreak: best,
      );
    }

    final badgeById = {for (final b in badges) b.id: b};
    for (final effect in outcome.badgeEffects) {
      final badge = badgeById[effect.badgeId];
      if (badge == null || badge.isUnlocked) {
        continue;
      }
      var nextBadge = badge.copyWith(progress: badge.progress + effect.progressDelta);
      if (effect.requestUnlock) {
        nextBadge = nextBadge.copyWith(
          isUnlocked: true,
          unlockedAt: eventOccurredAt,
        );
        nextProfile = _leveling.applyXpGain(nextProfile, badge.rewardXp);
      }
      badgeById[effect.badgeId] = nextBadge;
    }

    final challengeById = {for (final c in challenges) c.id: c};
    for (final effect in outcome.challengeEffects) {
      final challenge = challengeById[effect.challengeId];
      if (challenge == null || challenge.isCompleted) {
        continue;
      }
      final rawProgress = challenge.progress + effect.progressDelta;
      final clamped = rawProgress < 0 ? 0 : (rawProgress > challenge.target ? challenge.target : rawProgress);
      final completed = clamped >= challenge.target;
      final nextChallenge = challenge.copyWith(
        progress: clamped,
        isCompleted: completed,
      );
      challengeById[effect.challengeId] = nextChallenge;
      if (completed && !challenge.isCompleted) {
        nextProfile = _leveling.applyXpGain(nextProfile, challenge.rewardXp);
      }
    }

    final orderedBadges = badges.map((b) => badgeById[b.id]!).toList(growable: false);
    final orderedChallenges = challenges.map((c) => challengeById[c.id]!).toList(growable: false);
    return (nextProfile, orderedBadges, orderedChallenges);
  }
}
