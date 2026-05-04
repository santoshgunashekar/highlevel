import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_scope.dart';
import 'package:highlevel/gamification/domain/use_case/fetch_leaderboard_page_use_case.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_leaderboard_event.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_leaderboard_state.dart';

final class GamificationLeaderboardBloc
    extends Bloc<GamificationLeaderboardEvent, GamificationLeaderboardState> {
  GamificationLeaderboardBloc({
    required FetchLeaderboardPageUseCase fetchPage,
    this.pageSize = 12,
  })  : _fetchPage = fetchPage,
        super(const GamificationLeaderboardInitial()) {
    on<GamificationLeaderboardLoadRequested>(_onLoadRequested);
    on<GamificationLeaderboardLoadMoreRequested>(_onLoadMoreRequested);
  }

  static const _scope = LeaderboardScope.global;

  final FetchLeaderboardPageUseCase _fetchPage;
  final int pageSize;

  Future<void> _onLoadRequested(
    GamificationLeaderboardLoadRequested event,
    Emitter<GamificationLeaderboardState> emit,
  ) async {
    emit(const GamificationLeaderboardLoading());
    try {
      final page = await _fetchPage(
        scope: _scope,
        scopeId: null,
        page: 0,
        pageSize: pageSize,
      );
      emit(
        GamificationLeaderboardReady(
          entries: page.entries,
          hasNextPage: page.hasNextPage,
          nextPageToLoad: 1,
        ),
      );
    } catch (e, st) {
      assert(() {
        debugPrint('$e\n$st');
        return true;
      }());
      emit(GamificationLeaderboardFailure(e));
    }
  }

  Future<void> _onLoadMoreRequested(
    GamificationLeaderboardLoadMoreRequested event,
    Emitter<GamificationLeaderboardState> emit,
  ) async {
    final current = state;
    if (current is! GamificationLeaderboardReady ||
        !current.hasNextPage ||
        current.isLoadingMore) {
      return;
    }
    emit(current.copyWith(isLoadingMore: true));
    try {
      final page = await _fetchPage(
        scope: _scope,
        scopeId: null,
        page: current.nextPageToLoad,
        pageSize: pageSize,
      );
      emit(
        GamificationLeaderboardReady(
          entries: [...current.entries, ...page.entries],
          hasNextPage: page.hasNextPage,
          nextPageToLoad: current.nextPageToLoad + 1,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      assert(() {
        debugPrint('$e\n$st');
        return true;
      }());
      emit(current.copyWith(isLoadingMore: false));
    }
  }
}
