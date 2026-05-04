import 'package:highlevel/gamification/domain/model/leaderboard_entry.dart';

/// One page of leaderboard rows (supports lazy loading / pagination).
final class LeaderboardPage {
  const LeaderboardPage({
    required this.entries,
    required this.hasNextPage,
  });

  final List<LeaderboardEntry> entries;
  final bool hasNextPage;
}
