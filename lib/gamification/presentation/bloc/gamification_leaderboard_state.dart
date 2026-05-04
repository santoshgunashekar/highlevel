import 'package:highlevel/gamification/domain/model/leaderboard_entry.dart';

sealed class GamificationLeaderboardState {
  const GamificationLeaderboardState();
}

final class GamificationLeaderboardInitial extends GamificationLeaderboardState {
  const GamificationLeaderboardInitial();
}

final class GamificationLeaderboardLoading extends GamificationLeaderboardState {
  const GamificationLeaderboardLoading();
}

final class GamificationLeaderboardReady extends GamificationLeaderboardState {
  const GamificationLeaderboardReady({
    required this.entries,
    required this.hasNextPage,
    required this.nextPageToLoad,
    this.isLoadingMore = false,
  });

  final List<LeaderboardEntry> entries;
  final bool hasNextPage;
  final int nextPageToLoad;
  final bool isLoadingMore;

  GamificationLeaderboardReady copyWith({
    List<LeaderboardEntry>? entries,
    bool? hasNextPage,
    int? nextPageToLoad,
    bool? isLoadingMore,
  }) {
    return GamificationLeaderboardReady(
      entries: entries ?? this.entries,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      nextPageToLoad: nextPageToLoad ?? this.nextPageToLoad,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class GamificationLeaderboardFailure extends GamificationLeaderboardState {
  const GamificationLeaderboardFailure(this.error);

  final Object error;
}
