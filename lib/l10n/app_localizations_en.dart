// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Highlevel';

  @override
  String get gamificationDemoTitle => 'Gamification demo';

  @override
  String get gamificationLoadError => 'Could not load gamification. Try again.';

  @override
  String get gamificationRetryAction => 'Retry';

  @override
  String get gamificationSectionProfile => 'Progress';

  @override
  String get gamificationSectionBadges => 'Badges';

  @override
  String get gamificationSectionChallenges => 'Challenges';

  @override
  String get gamificationSectionSimulate => 'Simulate activity';

  @override
  String gamificationLevelLabel(int level) {
    return 'Level $level';
  }

  @override
  String gamificationXpLabel(int current, int next) {
    return '$current / $next XP to next level';
  }

  @override
  String gamificationStreakLabel(int current, int best) {
    return 'Streak $current (best $best)';
  }

  @override
  String get gamificationBadgeTitleQuickLearner => 'Quick learner';

  @override
  String get gamificationBadgeTitleCommunityHelper => 'Community helper';

  @override
  String gamificationBadgeProgress(String title, int progress, int target) {
    return '$title — $progress / $target';
  }

  @override
  String get gamificationBadgeUnlockedLabel => 'Unlocked';

  @override
  String get gamificationChallengeTitleWeekly => 'Weekly tasks';

  @override
  String gamificationChallengeProgress(String title, int progress, int target) {
    return '$title: $progress / $target';
  }

  @override
  String get gamificationEventLessonCompleted => 'Lesson completed';

  @override
  String get gamificationEventCommentCreated => 'Comment created';

  @override
  String get gamificationEventPostCreated => 'Post created';

  @override
  String get gamificationEventPeerReview => 'Peer review';

  @override
  String get gamificationEventTaskCompleted => 'Task completed';

  @override
  String get gamificationEventDailyLogin => 'Daily login';

  @override
  String get gamificationMockPostLikeSemanticsLabel =>
      'Simulate a post like using a comment-created event';

  @override
  String get gamificationMockPostLikeButtonLabel => 'Post liked (mock)';

  @override
  String get gamificationDuplicateEventMessage =>
      'That activity was already counted.';

  @override
  String get gamificationLeaderboardTitle => 'Leaderboard';

  @override
  String get gamificationLeaderboardLoadMore => 'Load more';

  @override
  String get gamificationLeaderboardEmpty => 'No leaderboard entries yet.';

  @override
  String gamificationLeaderboardXpLabel(int xp) {
    return '$xp XP';
  }

  @override
  String gamificationLeaderboardRankLabel(int rank) {
    return '#$rank';
  }

  @override
  String gamificationLeaderboardAvatarSemantics(String userName) {
    return 'Avatar for $userName';
  }

  @override
  String get gamificationLeaderboardRankTrendUp => 'Rank trending up';

  @override
  String get gamificationLeaderboardRankTrendDown => 'Rank trending down';

  @override
  String get gamificationLeaderboardRankTrendSame => 'Rank unchanged';

  @override
  String get gamificationLeaderboardOpenTooltip => 'Open leaderboard';
}
