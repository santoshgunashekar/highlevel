import 'package:highlevel/gamification/domain/model/leaderboard_rank_change.dart';

/// PRD `LeaderboardEntry`.
final class LeaderboardEntry {
  const LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.rank,
    required this.xp,
    required this.change,
  });

  final String userId;
  final String userName;
  final String avatarUrl;
  final int rank;
  final int xp;
  final LeaderboardRankChange change;
}
