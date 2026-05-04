import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_context.dart';
import 'package:highlevel/gamification/domain/rules/gamification_rule_outcome.dart';

/// Base contract for event-specific gamification logic.
///
/// Each [GamificationEventType] has its own rule implementation. The engine
/// resolves the rule for [GamificationRuleContext.event] and calls [evaluate].
abstract base class GamificationEventRule {
  const GamificationEventRule(this.eventType);

  final GamificationEventType eventType;

  GamificationRuleOutcome evaluate(GamificationRuleContext context);
}

/// Maps event types to rules and evaluates the rule for a context's event.
abstract interface class GamificationEventRuleRegistry {
  GamificationEventRule ruleFor(GamificationEventType type);
}

final class MapGamificationEventRuleRegistry
    implements GamificationEventRuleRegistry {
  MapGamificationEventRuleRegistry._(this._rulesByType);

  /// Builds a registry from [rules], requiring exactly one rule per
  /// [GamificationEventType] value.
  factory MapGamificationEventRuleRegistry.fromRules(
    Iterable<GamificationEventRule> rules,
  ) {
    final map = <GamificationEventType, GamificationEventRule>{};
    for (final rule in rules) {
      map[rule.eventType] = rule;
    }
    for (final type in GamificationEventType.values) {
      if (!map.containsKey(type)) {
        throw ArgumentError.value(
          rules,
          'rules',
          'Missing GamificationEventRule for $type',
        );
      }
    }
    return MapGamificationEventRuleRegistry._(Map.unmodifiable(map));
  }

  final Map<GamificationEventType, GamificationEventRule> _rulesByType;

  @override
  GamificationEventRule ruleFor(GamificationEventType type) {
    final rule = _rulesByType[type];
    if (rule == null) {
      throw StateError('No GamificationEventRule registered for $type');
    }
    return rule;
  }
}

final class GamificationEventRuleEvaluator {
  const GamificationEventRuleEvaluator(this._registry);

  final GamificationEventRuleRegistry _registry;

  GamificationRuleOutcome evaluate(GamificationRuleContext context) {
    return _registry.ruleFor(context.event.type).evaluate(context);
  }
}
