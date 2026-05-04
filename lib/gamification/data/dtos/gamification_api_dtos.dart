import 'package:json_annotation/json_annotation.dart';
import 'package:highlevel/gamification/domain/model/badge.dart';
import 'package:highlevel/gamification/domain/model/badge_category.dart';
import 'package:highlevel/gamification/domain/model/challenge.dart';
import 'package:highlevel/gamification/domain/model/gamification_dashboard.dart';
import 'package:highlevel/gamification/domain/model/gamification_event.dart';
import 'package:highlevel/gamification/domain/model/gamification_event_type.dart';
import 'package:highlevel/gamification/domain/model/gamification_profile.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_entry.dart';
import 'package:highlevel/gamification/domain/model/leaderboard_rank_change.dart';

part 'gamification_api_dtos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class GamificationProfileDto {
  const GamificationProfileDto({
    required this.userId,
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.currentStreak,
    required this.bestStreak,
    required this.streakFreezeCount,
  });

  factory GamificationProfileDto.fromJson(Map<String, dynamic> json) =>
      _$GamificationProfileDtoFromJson(json);

  final String userId;
  final int level;
  final int currentXp;
  final int nextLevelXp;
  final int currentStreak;
  final int bestStreak;
  final int streakFreezeCount;

  Map<String, dynamic> toJson() => _$GamificationProfileDtoToJson(this);

  GamificationProfile toDomain() {
    return GamificationProfile(
      userId: userId,
      level: level,
      currentXp: currentXp,
      nextLevelXp: nextLevelXp,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
      streakFreezeCount: streakFreezeCount,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class BadgeDto {
  const BadgeDto({
    required this.id,
    required this.title,
    required this.category,
    required this.progress,
    required this.isUnlocked,
    required this.rewardXp,
    this.unlockedAt,
  });

  factory BadgeDto.fromJson(Map<String, dynamic> json) => _$BadgeDtoFromJson(json);

  final String id;
  final String title;
  final String category;
  final int progress;
  final bool isUnlocked;
  final int rewardXp;
  final String? unlockedAt;

  Map<String, dynamic> toJson() => _$BadgeDtoToJson(this);

  Badge toDomain() {
    return Badge(
      id: id,
      title: title,
      category: _parseBadgeCategory(category),
      progress: progress,
      isUnlocked: isUnlocked,
      rewardXp: rewardXp,
      unlockedAt: unlockedAt == null ? null : DateTime.parse(unlockedAt!).toUtc(),
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class ChallengeDto {
  const ChallengeDto({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.rewardXp,
    required this.isCompleted,
  });

  factory ChallengeDto.fromJson(Map<String, dynamic> json) =>
      _$ChallengeDtoFromJson(json);

  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;
  final int rewardXp;
  final bool isCompleted;

  Map<String, dynamic> toJson() => _$ChallengeDtoToJson(this);

  Challenge toDomain() {
    return Challenge(
      id: id,
      title: title,
      description: description,
      progress: progress,
      target: target,
      rewardXp: rewardXp,
      isCompleted: isCompleted,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class LeaderboardEntryDto {
  const LeaderboardEntryDto({
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.rank,
    required this.xp,
    @JsonKey(name: 'change') required this.change,
  });

  factory LeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryDtoFromJson(json);

  final String userId;
  final String userName;
  final String avatarUrl;
  final int rank;
  final int xp;
  final String change;

  Map<String, dynamic> toJson() => _$LeaderboardEntryDtoToJson(this);

  LeaderboardEntry toDomain() {
    return LeaderboardEntry(
      userId: userId,
      userName: userName,
      avatarUrl: avatarUrl,
      rank: rank,
      xp: xp,
      change: _parseRankChange(change),
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class LeaderboardPageResponseDto {
  const LeaderboardPageResponseDto({
    required this.entries,
    required this.hasNextPage,
  });

  factory LeaderboardPageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardPageResponseDtoFromJson(json);

  final List<LeaderboardEntryDto> entries;
  final bool hasNextPage;

  Map<String, dynamic> toJson() => _$LeaderboardPageResponseDtoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class GamificationDashboardDto {
  const GamificationDashboardDto({
    required this.profile,
    required this.badges,
    required this.challenges,
  });

  factory GamificationDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$GamificationDashboardDtoFromJson(json);

  final GamificationProfileDto profile;
  final List<BadgeDto> badges;
  final List<ChallengeDto> challenges;

  Map<String, dynamic> toJson() => _$GamificationDashboardDtoToJson(this);

  GamificationDashboard toDomain() {
    return GamificationDashboard(
      profile: profile.toDomain(),
      badges: badges.map((b) => b.toDomain()).toList(growable: false),
      challenges: challenges.map((c) => c.toDomain()).toList(growable: false),
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class GamificationEventDto {
  const GamificationEventDto({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.metadata,
  });

  factory GamificationEventDto.fromJson(Map<String, dynamic> json) =>
      _$GamificationEventDtoFromJson(json);

  final String id;
  final String type;
  final String createdAt;
  final Map<String, dynamic> metadata;

  Map<String, dynamic> toJson() => _$GamificationEventDtoToJson(this);

  GamificationEvent toDomain() {
    return GamificationEvent(
      id: id,
      type: _parseGamificationEventType(type),
      createdAt: DateTime.parse(createdAt).toUtc(),
      metadata: metadata.map(
        (key, value) => MapEntry<String, Object?>(key, value as Object?),
      ),
    );
  }
}

extension GamificationEventDomainDto on GamificationEvent {
  GamificationEventDto toDto() {
    return GamificationEventDto(
      id: id,
      type: type.toWire(),
      createdAt: createdAt.toUtc().toIso8601String(),
      metadata: metadata.map(
        (key, value) => MapEntry<String, dynamic>(key, value),
      ),
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class SyncGamificationEventsResultDto {
  const SyncGamificationEventsResultDto({
    required this.appliedCount,
    required this.duplicateSkippedCount,
    required this.dashboard,
  });

  factory SyncGamificationEventsResultDto.fromJson(Map<String, dynamic> json) =>
      _$SyncGamificationEventsResultDtoFromJson(json);

  final int appliedCount;
  final int duplicateSkippedCount;
  final GamificationDashboardDto dashboard;

  Map<String, dynamic> toJson() => _$SyncGamificationEventsResultDtoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
final class GamificationEventRecordingResultDto {
  const GamificationEventRecordingResultDto({
    required this.dashboard,
    required this.wasDuplicate,
  });

  factory GamificationEventRecordingResultDto.fromJson(
    Map<String, dynamic> json,
  ) => _$GamificationEventRecordingResultDtoFromJson(json);

  final GamificationDashboardDto dashboard;
  final bool wasDuplicate;

  Map<String, dynamic> toJson() =>
      _$GamificationEventRecordingResultDtoToJson(this);
}

BadgeCategory _parseBadgeCategory(String raw) {
  return BadgeCategory.values.firstWhere(
    (e) => e.name == raw,
    orElse: () => BadgeCategory.learning,
  );
}

LeaderboardRankChange _parseRankChange(String raw) {
  return LeaderboardRankChange.values.firstWhere(
    (e) => e.name == raw,
    orElse: () => LeaderboardRankChange.same,
  );
}

GamificationEventType _parseGamificationEventType(String raw) {
  return switch (raw) {
    'lesson_completed' => GamificationEventType.lessonCompleted,
    'comment_created' => GamificationEventType.commentCreated,
    'post_created' => GamificationEventType.postCreated,
    'peer_review' => GamificationEventType.peerReview,
    'task_completed' => GamificationEventType.taskCompleted,
    'daily_login' => GamificationEventType.dailyLogin,
    _ => GamificationEventType.dailyLogin,
  };
}

extension GamificationEventTypeWire on GamificationEventType {
  String toWire() {
    return switch (this) {
      GamificationEventType.lessonCompleted => 'lesson_completed',
      GamificationEventType.commentCreated => 'comment_created',
      GamificationEventType.postCreated => 'post_created',
      GamificationEventType.peerReview => 'peer_review',
      GamificationEventType.taskCompleted => 'task_completed',
      GamificationEventType.dailyLogin => 'daily_login',
    };
  }
}
