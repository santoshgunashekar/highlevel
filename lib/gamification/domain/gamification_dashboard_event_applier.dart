import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';
import 'package:highlevel/gamification/domain/rules/gamification_event_rule.dart';
import 'package:highlevel/gamification/domain/rules/gamification_outcome_applier.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_context.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_outcome.dart';

/// Applies [GamificationEventRuleRegistry] + [GamificationOutcomeApplier] to a
/// dashboard snapshot (used for optimistic UI and for repository replay).
final class GamificationDashboardEventApplier {
  GamificationDashboardEventApplier({
    required GamificationEventRuleEvaluator ruleEvaluator,
    required GamificationOutcomeApplier outcomeApplier,
  })  : _ruleEvaluator = ruleEvaluator,
        _outcomeApplier = outcomeApplier;

  static const quickLearnerBadgeId = 'quick_learner';
  static const communityHelperBadgeId = 'community_helper';
  static const weeklyTasksChallengeId = 'weekly_tasks';
  static const badgeUnlockThreshold = 3;

  final GamificationEventRuleEvaluator _ruleEvaluator;
  final GamificationOutcomeApplier _outcomeApplier;

  GamificationDashboard apply({
    required GamificationDashboard dashboard,
    required GamificationEvent event,
  }) {
    final context = GamificationRuleContext(
      event: event,
      profile: dashboard.profile,
      badges: dashboard.badges,
      challenges: dashboard.challenges,
    );
    final baseOutcome = _ruleEvaluator.evaluate(context);
    final outcome = _withDemoProgress(event, dashboard, baseOutcome);

    final applied = _outcomeApplier.apply(
      profile: dashboard.profile,
      badges: dashboard.badges,
      challenges: dashboard.challenges,
      outcome: outcome,
      eventOccurredAt: event.createdAt,
    );

    return GamificationDashboard(
      profile: applied.$1,
      badges: applied.$2,
      challenges: applied.$3,
    );
  }

  Badge? _badge(GamificationDashboard dashboard, String id) {
    for (final b in dashboard.badges) {
      if (b.id == id) {
        return b;
      }
    }
    return null;
  }

  GamificationRuleOutcome _withDemoProgress(
    GamificationEvent event,
    GamificationDashboard dashboard,
    GamificationRuleOutcome base,
  ) {
    final extraBadges = <GamificationBadgeEffect>[];
    final extraChallenges = <GamificationChallengeEffect>[];

    if (event.type == GamificationEventType.lessonCompleted) {
      final b = _badge(dashboard, quickLearnerBadgeId);
      if (b != null && !b.isUnlocked) {
        final next = b.progress + 1;
        extraBadges.add(
          GamificationBadgeEffect(
            badgeId: quickLearnerBadgeId,
            progressDelta: 1,
            requestUnlock: next >= badgeUnlockThreshold,
          ),
        );
      }
    }
    if (event.type == GamificationEventType.commentCreated) {
      final b = _badge(dashboard, communityHelperBadgeId);
      if (b != null && !b.isUnlocked) {
        final next = b.progress + 1;
        extraBadges.add(
          GamificationBadgeEffect(
            badgeId: communityHelperBadgeId,
            progressDelta: 1,
            requestUnlock: next >= badgeUnlockThreshold,
          ),
        );
      }
    }
    if (event.type == GamificationEventType.taskCompleted) {
      extraChallenges.add(
        const GamificationChallengeEffect(
          challengeId: weeklyTasksChallengeId,
          progressDelta: 1,
        ),
      );
    }

    return GamificationRuleOutcome(
      xpDelta: base.xpDelta,
      streakDelta: base.streakDelta,
      badgeEffects: [...base.badgeEffects, ...extraBadges],
      challengeEffects: [...base.challengeEffects, ...extraChallenges],
    );
  }
}
