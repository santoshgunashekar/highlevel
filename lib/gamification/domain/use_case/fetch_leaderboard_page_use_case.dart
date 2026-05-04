import 'package:highlevel/gamification/domain/model/leaderboard_page.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/repository/gamification_repository.dart';

final class FetchLeaderboardPageUseCase {
  const FetchLeaderboardPageUseCase(this._repository);

  final GamificationRepository _repository;

  Future<LeaderboardPage> call({
    required LeaderboardScope scope,
    String? scopeId,
    required int page,
    required int pageSize,
  }) {
    return _repository.fetchLeaderboardPage(
      scope: scope,
      scopeId: scopeId,
      page: page,
      pageSize: pageSize,
    );
  }
}
