import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_entry.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_rank_change.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_leaderboard_bloc.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_leaderboard_event.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_leaderboard_state.dart';
import 'package:highlevel/init.dart';
import 'package:highlevel/l10n/app_localizations.dart';

final class GamificationLeaderboardPage extends StatelessWidget {
  const GamificationLeaderboardPage({super.key, required this.viewerUserId});

  final String viewerUserId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GamificationLeaderboardBloc(fetchPage: sl())
        ..add(const GamificationLeaderboardLoadRequested()),
      child: _GamificationLeaderboardScaffold(viewerUserId: viewerUserId),
    );
  }
}

final class _GamificationLeaderboardScaffold extends StatelessWidget {
  const _GamificationLeaderboardScaffold({required this.viewerUserId});

  final String viewerUserId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gamificationLeaderboardTitle),
        backgroundColor: scheme.inversePrimary,
      ),
      body: BlocBuilder<GamificationLeaderboardBloc, GamificationLeaderboardState>(
        builder: (context, state) {
          return switch (state) {
            GamificationLeaderboardInitial() ||
            GamificationLeaderboardLoading() =>
              const Center(child: CircularProgressIndicator()),
            GamificationLeaderboardFailure() => _LeaderboardErrorBody(
                onRetry: () => context.read<GamificationLeaderboardBloc>().add(
                      const GamificationLeaderboardLoadRequested(),
                    ),
              ),
            GamificationLeaderboardReady(:final entries, :final hasNextPage, :final isLoadingMore) =>
              entries.isEmpty
                  ? Center(child: Text(l10n.gamificationLeaderboardEmpty))
                  : _LeaderboardListBody(
                      entries: entries,
                      hasNextPage: hasNextPage,
                      isLoadingMore: isLoadingMore,
                      viewerUserId: viewerUserId,
                    ),
          };
        },
      ),
    );
  }
}

final class _LeaderboardErrorBody extends StatelessWidget {
  const _LeaderboardErrorBody({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: 16),
            Text(
              l10n.gamificationLoadError,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: Text(l10n.gamificationRetryAction)),
          ],
        ),
      ),
    );
  }
}

final class _LeaderboardListBody extends StatelessWidget {
  const _LeaderboardListBody({
    required this.entries,
    required this.hasNextPage,
    required this.isLoadingMore,
    required this.viewerUserId,
  });

  final List<LeaderboardEntry> entries;
  final bool hasNextPage;
  final bool isLoadingMore;
  final String viewerUserId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<GamificationLeaderboardBloc>();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: entries.length + (hasNextPage || isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == entries.length) {
          if (isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: FilledButton.tonal(
              onPressed: () => bloc.add(const GamificationLeaderboardLoadMoreRequested()),
              child: Text(l10n.gamificationLeaderboardLoadMore),
            ),
          );
        }
        final entry = entries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _LeaderboardEntryTile(
            entry: entry,
            isViewer: entry.userId == viewerUserId,
          ),
        );
      },
    );
  }
}

final class _LeaderboardEntryTile extends StatelessWidget {
  const _LeaderboardEntryTile({
    required this.entry,
    required this.isViewer,
  });

  final LeaderboardEntry entry;
  final bool isViewer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final trend = _RankTrendStyle.from(entry.change, scheme);

    final initial = entry.userName.isNotEmpty ? entry.userName[0].toUpperCase() : '?';

    return Card(
      color: isViewer ? scheme.primaryContainer : null,
      child: ListTile(
        leading: Semantics(
          label: l10n.gamificationLeaderboardAvatarSemantics(entry.userName),
          child: SizedBox(
            width: 48,
            height: 48,
            child: ClipOval(
              child: Image.network(
                entry.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: scheme.surfaceContainerHighest,
                  child: Center(
                    child: Text(
                      initial,
                      style: textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          entry.userName,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: isViewer ? FontWeight.w600 : null,
          ),
        ),
        subtitle: Text(
          l10n.gamificationLeaderboardXpLabel(entry.xp),
          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.gamificationLeaderboardRankLabel(entry.rank),
              style: textTheme.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(width: 8),
            Semantics(
              label: trend.semanticsLabel(l10n),
              child: Icon(trend.icon, color: trend.color, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}

final class _RankTrendStyle {
  const _RankTrendStyle({
    required this.icon,
    required this.color,
    required this.semanticsLabel,
  });

  final IconData icon;
  final Color color;
  final String Function(AppLocalizations l10n) semanticsLabel;

  static _RankTrendStyle from(LeaderboardRankChange change, ColorScheme scheme) {
    return switch (change) {
      LeaderboardRankChange.up => _RankTrendStyle(
          icon: Icons.trending_up,
          color: scheme.tertiary,
          semanticsLabel: (l10n) => l10n.gamificationLeaderboardRankTrendUp,
        ),
      LeaderboardRankChange.down => _RankTrendStyle(
          icon: Icons.trending_down,
          color: scheme.error,
          semanticsLabel: (l10n) => l10n.gamificationLeaderboardRankTrendDown,
        ),
      LeaderboardRankChange.same => _RankTrendStyle(
          icon: Icons.horizontal_rule,
          color: scheme.onSurfaceVariant,
          semanticsLabel: (l10n) => l10n.gamificationLeaderboardRankTrendSame,
        ),
    };
  }
}
