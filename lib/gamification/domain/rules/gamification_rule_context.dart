import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';

/// Snapshot passed into a rule when an event is processed.
///
/// Callers should de-duplicate by [GamificationEvent.id] before evaluation;
/// rules assume each [event] is applied at most once per profile revision.
final class GamificationRuleContext {
  const GamificationRuleContext({
    required this.event,
    required this.profile,
    required this.badges,
    required this.challenges,
  });

  final GamificationEvent event;
  final GamificationProfile profile;
  final List<Badge> badges;
  final List<Challenge> challenges;
}
