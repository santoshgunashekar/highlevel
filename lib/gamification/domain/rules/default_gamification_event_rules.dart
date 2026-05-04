import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';
import 'package:highlevel/gamification/domain/rules/gamification_event_rule.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_context.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_outcome.dart';

final class FixedXpGamificationEventRule extends GamificationEventRule {
  const FixedXpGamificationEventRule(
    super.eventType,
    this.xpAward, {
    this.streakDelta = 0,
  });

  final int xpAward;
  final int streakDelta;

  @override
  GamificationRuleOutcome evaluate(GamificationRuleContext context) {
    return GamificationRuleOutcome(
      xpDelta: xpAward,
      streakDelta: streakDelta,
    );
  }
}

final class MetadataCappedXpGamificationEventRule extends GamificationEventRule {
  const MetadataCappedXpGamificationEventRule(
    super.eventType,
    this.defaultXp, {
    this.maxXp = 500,
  });

  final int defaultXp;
  final int maxXp;

  @override
  GamificationRuleOutcome evaluate(GamificationRuleContext context) {
    final raw = context.event.metadata['xpOverride'];
    final override = raw is int ? raw : (raw is num ? raw.toInt() : null);
    final xp = override == null
        ? defaultXp
        : override.clamp(0, maxXp).toInt();
    return GamificationRuleOutcome(xpDelta: xp);
  }
}

MapGamificationEventRuleRegistry createDefaultGamificationRuleRegistry() {
  return MapGamificationEventRuleRegistry.fromRules(const [
    FixedXpGamificationEventRule(GamificationEventType.lessonCompleted, 50),
    FixedXpGamificationEventRule(GamificationEventType.commentCreated, 10),
    FixedXpGamificationEventRule(GamificationEventType.postCreated, 15),
    FixedXpGamificationEventRule(GamificationEventType.peerReview, 25),
    MetadataCappedXpGamificationEventRule(GamificationEventType.taskCompleted, 30),
    FixedXpGamificationEventRule(
      GamificationEventType.dailyLogin,
      5,
      streakDelta: 1,
    ),
  ]);
}
