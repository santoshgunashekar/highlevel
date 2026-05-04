import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Highlevel'**
  String get appTitle;

  /// No description provided for @gamificationDemoTitle.
  ///
  /// In en, this message translates to:
  /// **'Gamification demo'**
  String get gamificationDemoTitle;

  /// No description provided for @gamificationLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load gamification. Try again.'**
  String get gamificationLoadError;

  /// No description provided for @gamificationRetryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get gamificationRetryAction;

  /// No description provided for @gamificationSectionProfile.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get gamificationSectionProfile;

  /// No description provided for @gamificationSectionBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get gamificationSectionBadges;

  /// No description provided for @gamificationSectionChallenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get gamificationSectionChallenges;

  /// No description provided for @gamificationSectionSimulate.
  ///
  /// In en, this message translates to:
  /// **'Simulate activity'**
  String get gamificationSectionSimulate;

  /// No description provided for @gamificationLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String gamificationLevelLabel(int level);

  /// No description provided for @gamificationXpLabel.
  ///
  /// In en, this message translates to:
  /// **'{current} / {next} XP to next level'**
  String gamificationXpLabel(int current, int next);

  /// No description provided for @gamificationStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak {current} (best {best})'**
  String gamificationStreakLabel(int current, int best);

  /// No description provided for @gamificationBadgeTitleQuickLearner.
  ///
  /// In en, this message translates to:
  /// **'Quick learner'**
  String get gamificationBadgeTitleQuickLearner;

  /// No description provided for @gamificationBadgeTitleCommunityHelper.
  ///
  /// In en, this message translates to:
  /// **'Community helper'**
  String get gamificationBadgeTitleCommunityHelper;

  /// No description provided for @gamificationBadgeProgress.
  ///
  /// In en, this message translates to:
  /// **'{title} — {progress} / {target}'**
  String gamificationBadgeProgress(String title, int progress, int target);

  /// No description provided for @gamificationBadgeUnlockedLabel.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get gamificationBadgeUnlockedLabel;

  /// No description provided for @gamificationChallengeTitleWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly tasks'**
  String get gamificationChallengeTitleWeekly;

  /// No description provided for @gamificationChallengeProgress.
  ///
  /// In en, this message translates to:
  /// **'{title}: {progress} / {target}'**
  String gamificationChallengeProgress(String title, int progress, int target);

  /// No description provided for @gamificationEventLessonCompleted.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed'**
  String get gamificationEventLessonCompleted;

  /// No description provided for @gamificationEventCommentCreated.
  ///
  /// In en, this message translates to:
  /// **'Comment created'**
  String get gamificationEventCommentCreated;

  /// No description provided for @gamificationEventPostCreated.
  ///
  /// In en, this message translates to:
  /// **'Post created'**
  String get gamificationEventPostCreated;

  /// No description provided for @gamificationEventPeerReview.
  ///
  /// In en, this message translates to:
  /// **'Peer review'**
  String get gamificationEventPeerReview;

  /// No description provided for @gamificationEventTaskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task completed'**
  String get gamificationEventTaskCompleted;

  /// No description provided for @gamificationEventDailyLogin.
  ///
  /// In en, this message translates to:
  /// **'Daily login'**
  String get gamificationEventDailyLogin;

  /// No description provided for @gamificationMockPostLikeSemanticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Simulate a post like using a comment-created event'**
  String get gamificationMockPostLikeSemanticsLabel;

  /// No description provided for @gamificationMockPostLikeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Post liked (mock)'**
  String get gamificationMockPostLikeButtonLabel;

  /// No description provided for @gamificationDuplicateEventMessage.
  ///
  /// In en, this message translates to:
  /// **'That activity was already counted.'**
  String get gamificationDuplicateEventMessage;

  /// No description provided for @gamificationLeaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get gamificationLeaderboardTitle;

  /// No description provided for @gamificationLeaderboardLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get gamificationLeaderboardLoadMore;

  /// No description provided for @gamificationLeaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard entries yet.'**
  String get gamificationLeaderboardEmpty;

  /// No description provided for @gamificationLeaderboardXpLabel.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String gamificationLeaderboardXpLabel(int xp);

  /// No description provided for @gamificationLeaderboardRankLabel.
  ///
  /// In en, this message translates to:
  /// **'#{rank}'**
  String gamificationLeaderboardRankLabel(int rank);

  /// No description provided for @gamificationLeaderboardAvatarSemantics.
  ///
  /// In en, this message translates to:
  /// **'Avatar for {userName}'**
  String gamificationLeaderboardAvatarSemantics(String userName);

  /// No description provided for @gamificationLeaderboardRankTrendUp.
  ///
  /// In en, this message translates to:
  /// **'Rank trending up'**
  String get gamificationLeaderboardRankTrendUp;

  /// No description provided for @gamificationLeaderboardRankTrendDown.
  ///
  /// In en, this message translates to:
  /// **'Rank trending down'**
  String get gamificationLeaderboardRankTrendDown;

  /// No description provided for @gamificationLeaderboardRankTrendSame.
  ///
  /// In en, this message translates to:
  /// **'Rank unchanged'**
  String get gamificationLeaderboardRankTrendSame;

  /// No description provided for @gamificationLeaderboardOpenTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open leaderboard'**
  String get gamificationLeaderboardOpenTooltip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
