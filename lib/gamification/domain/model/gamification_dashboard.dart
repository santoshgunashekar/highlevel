import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';

/// Aggregated read model for the current user's gamification home state.
final class GamificationDashboard {
  const GamificationDashboard({
    required this.profile,
    required this.badges,
    required this.challenges,
  });

  final GamificationProfile profile;
  final List<Badge> badges;
  final List<Challenge> challenges;
}
