import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlevel/l10n/app_localizations.dart';
import 'package:highlevel/gamification/domain/gamification_dashboard_event_applier.dart';
import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';
import 'package:highlevel/gamification/gamification_di.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_dashboard_bloc.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_dashboard_event.dart';
import 'package:highlevel/gamification/presentation/bloc/gamification_dashboard_state.dart';
import 'package:highlevel/gamification/presentation/ui/gamification_leaderboard_page.dart';
import 'package:highlevel/init.dart';

final class GamificationDashboardPage extends StatelessWidget {
  const GamificationDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GamificationDashboardBloc(
        loadDashboard: sl(),
        recordEvent: sl(),
        dashboardEventApplier: sl(),
        userId: GamificationDi.demoUserId,
      )..add(const GamificationDashboardLoadRequested()),
      child: const _GamificationDashboardScaffold(),
    );
  }
}

final class _GamificationDashboardScaffold extends StatelessWidget {
  const _GamificationDashboardScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gamificationDemoTitle),
        backgroundColor: scheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: l10n.gamificationLeaderboardOpenTooltip,
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => GamificationLeaderboardPage(
                    viewerUserId: GamificationDi.demoUserId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<GamificationDashboardBloc, GamificationDashboardState>(
        listenWhen: (previous, current) =>
            current is GamificationDashboardReady && current.lastRecordWasDuplicate,
        listener: (context, state) {
          final messages = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(messages.gamificationDuplicateEventMessage)),
          );
        },
        child: BlocBuilder<GamificationDashboardBloc, GamificationDashboardState>(
          builder: (context, state) {
            return switch (state) {
              GamificationDashboardInitial() ||
              GamificationDashboardLoading() =>
                const Center(child: CircularProgressIndicator()),
              GamificationDashboardFailure(error: _) => _LoadErrorPanel(
                  onRetry: () => context.read<GamificationDashboardBloc>().add(
                        const GamificationDashboardLoadRequested(),
                      ),
                ),
              GamificationDashboardReady(:final dashboard) => _DashboardScrollBody(
                  dashboard: dashboard,
                ),
            };
          },
        ),
      ),
    );
  }
}

final class _LoadErrorPanel extends StatelessWidget {
  const _LoadErrorPanel({required this.onRetry});

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

final class _DashboardScrollBody extends StatelessWidget {
  const _DashboardScrollBody({required this.dashboard});

  final GamificationDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.gamificationSectionProfile,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _ProfileCard(profile: dashboard.profile),
          const SizedBox(height: 24),
          Text(
            l10n.gamificationSectionBadges,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _BadgesColumn(badges: dashboard.badges),
          const SizedBox(height: 24),
          Text(
            l10n.gamificationSectionChallenges,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _ChallengesColumn(challenges: dashboard.challenges),
          const SizedBox(height: 24),
          Text(
            l10n.gamificationSectionSimulate,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const _MockEventButtonGrid(),
        ],
      ),
    );
  }
}

final class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile});

  final GamificationProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final nextXp = profile.nextLevelXp <= 0 ? 1 : profile.nextLevelXp;
    final xpProgress = profile.currentXp / nextXp;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.gamificationLevelLabel(profile.level),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: xpProgress.clamp(0.0, 1.0), minHeight: 8),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.gamificationXpLabel(profile.currentXp, profile.nextLevelXp),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.gamificationStreakLabel(profile.currentStreak, profile.bestStreak),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

final class _BadgesColumn extends StatelessWidget {
  const _BadgesColumn({required this.badges});

  final List<Badge> badges;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < badges.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _BadgeTile(badge: badges[i]),
        ],
      ],
    );
  }
}

final class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});

  final Badge badge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final title = _localizedBadgeTitle(l10n, badge);
    final target = GamificationDashboardEventApplier.badgeUnlockThreshold;

    return Card(
      child: ListTile(
        leading: Icon(
          badge.isUnlocked ? Icons.workspace_premium : Icons.workspace_premium_outlined,
          color: badge.isUnlocked ? scheme.primary : scheme.onSurfaceVariant,
        ),
        title: Text(title),
        subtitle: Text(
          badge.isUnlocked
              ? l10n.gamificationBadgeUnlockedLabel
              : l10n.gamificationBadgeProgress(title, badge.progress, target),
        ),
      ),
    );
  }
}

String _localizedBadgeTitle(AppLocalizations l10n, Badge badge) {
  return switch (badge.id) {
    GamificationDashboardEventApplier.quickLearnerBadgeId =>
      l10n.gamificationBadgeTitleQuickLearner,
    GamificationDashboardEventApplier.communityHelperBadgeId =>
      l10n.gamificationBadgeTitleCommunityHelper,
    _ => badge.title,
  };
}

String _localizedChallengeTitle(AppLocalizations l10n, Challenge challenge) {
  return switch (challenge.id) {
    GamificationDashboardEventApplier.weeklyTasksChallengeId =>
      l10n.gamificationChallengeTitleWeekly,
    _ => challenge.title,
  };
}

final class _ChallengesColumn extends StatelessWidget {
  const _ChallengesColumn({required this.challenges});

  final List<Challenge> challenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < challenges.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _ChallengeTile(challenge: challenges[i]),
        ],
      ],
    );
  }
}

final class _ChallengeTile extends StatelessWidget {
  const _ChallengeTile({required this.challenge});

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final title = _localizedChallengeTitle(l10n, challenge);

    return Card(
      child: ListTile(
        leading: Icon(
          challenge.isCompleted ? Icons.check_circle : Icons.flag_outlined,
          color: challenge.isCompleted ? scheme.primary : scheme.onSurfaceVariant,
        ),
        title: Text(title),
        subtitle: Text(
          l10n.gamificationChallengeProgress(title, challenge.progress, challenge.target),
        ),
      ),
    );
  }
}

final class _MockEventButtonGrid extends StatelessWidget {
  const _MockEventButtonGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    void dispatch(GamificationEventType type) {
      context.read<GamificationDashboardBloc>().add(
            GamificationDashboardMockEventTriggered(type),
          );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton.tonal(
          onPressed: () => dispatch(GamificationEventType.lessonCompleted),
          child: Text(l10n.gamificationEventLessonCompleted),
        ),
        Tooltip(
          message: l10n.gamificationMockPostLikeSemanticsLabel,
          child: FilledButton.tonal(
            onPressed: () => dispatch(GamificationEventType.commentCreated),
            child: Text(l10n.gamificationMockPostLikeButtonLabel),
          ),
        ),
        FilledButton.tonal(
          onPressed: () => dispatch(GamificationEventType.postCreated),
          child: Text(l10n.gamificationEventPostCreated),
        ),
        FilledButton.tonal(
          onPressed: () => dispatch(GamificationEventType.peerReview),
          child: Text(l10n.gamificationEventPeerReview),
        ),
        FilledButton.tonal(
          onPressed: () => dispatch(GamificationEventType.taskCompleted),
          child: Text(l10n.gamificationEventTaskCompleted),
        ),
        FilledButton.tonal(
          onPressed: () => dispatch(GamificationEventType.dailyLogin),
          child: Text(l10n.gamificationEventDailyLogin),
        ),
      ],
    );
  }
}
