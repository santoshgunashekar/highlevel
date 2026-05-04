// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_api_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamificationProfileDto _$GamificationProfileDtoFromJson(
  Map<String, dynamic> json,
) => GamificationProfileDto(
  userId: json['user_id'] as String,
  level: (json['level'] as num).toInt(),
  currentXp: (json['current_xp'] as num).toInt(),
  nextLevelXp: (json['next_level_xp'] as num).toInt(),
  currentStreak: (json['current_streak'] as num).toInt(),
  bestStreak: (json['best_streak'] as num).toInt(),
  streakFreezeCount: (json['streak_freeze_count'] as num).toInt(),
);

Map<String, dynamic> _$GamificationProfileDtoToJson(
  GamificationProfileDto instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'level': instance.level,
  'current_xp': instance.currentXp,
  'next_level_xp': instance.nextLevelXp,
  'current_streak': instance.currentStreak,
  'best_streak': instance.bestStreak,
  'streak_freeze_count': instance.streakFreezeCount,
};

BadgeDto _$BadgeDtoFromJson(Map<String, dynamic> json) => BadgeDto(
  id: json['id'] as String,
  title: json['title'] as String,
  category: json['category'] as String,
  progress: (json['progress'] as num).toInt(),
  isUnlocked: json['is_unlocked'] as bool,
  rewardXp: (json['reward_xp'] as num).toInt(),
  unlockedAt: json['unlocked_at'] as String?,
);

Map<String, dynamic> _$BadgeDtoToJson(BadgeDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'category': instance.category,
  'progress': instance.progress,
  'is_unlocked': instance.isUnlocked,
  'reward_xp': instance.rewardXp,
  'unlocked_at': instance.unlockedAt,
};

ChallengeDto _$ChallengeDtoFromJson(Map<String, dynamic> json) => ChallengeDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  progress: (json['progress'] as num).toInt(),
  target: (json['target'] as num).toInt(),
  rewardXp: (json['reward_xp'] as num).toInt(),
  isCompleted: json['is_completed'] as bool,
);

Map<String, dynamic> _$ChallengeDtoToJson(ChallengeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'progress': instance.progress,
      'target': instance.target,
      'reward_xp': instance.rewardXp,
      'is_completed': instance.isCompleted,
    };

LeaderboardEntryDto _$LeaderboardEntryDtoFromJson(Map<String, dynamic> json) =>
    LeaderboardEntryDto(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      avatarUrl: json['avatar_url'] as String,
      rank: (json['rank'] as num).toInt(),
      xp: (json['xp'] as num).toInt(),
      change: json['change'] as String,
    );

Map<String, dynamic> _$LeaderboardEntryDtoToJson(
  LeaderboardEntryDto instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_name': instance.userName,
  'avatar_url': instance.avatarUrl,
  'rank': instance.rank,
  'xp': instance.xp,
  'change': instance.change,
};

LeaderboardPageResponseDto _$LeaderboardPageResponseDtoFromJson(
  Map<String, dynamic> json,
) => LeaderboardPageResponseDto(
  entries: (json['entries'] as List<dynamic>)
      .map((e) => LeaderboardEntryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasNextPage: json['has_next_page'] as bool,
);

Map<String, dynamic> _$LeaderboardPageResponseDtoToJson(
  LeaderboardPageResponseDto instance,
) => <String, dynamic>{
  'entries': instance.entries.map((e) => e.toJson()).toList(),
  'has_next_page': instance.hasNextPage,
};

GamificationDashboardDto _$GamificationDashboardDtoFromJson(
  Map<String, dynamic> json,
) => GamificationDashboardDto(
  profile: GamificationProfileDto.fromJson(
    json['profile'] as Map<String, dynamic>,
  ),
  badges: (json['badges'] as List<dynamic>)
      .map((e) => BadgeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  challenges: (json['challenges'] as List<dynamic>)
      .map((e) => ChallengeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GamificationDashboardDtoToJson(
  GamificationDashboardDto instance,
) => <String, dynamic>{
  'profile': instance.profile.toJson(),
  'badges': instance.badges.map((e) => e.toJson()).toList(),
  'challenges': instance.challenges.map((e) => e.toJson()).toList(),
};

GamificationEventDto _$GamificationEventDtoFromJson(
  Map<String, dynamic> json,
) => GamificationEventDto(
  id: json['id'] as String,
  type: json['type'] as String,
  createdAt: json['created_at'] as String,
  metadata: json['metadata'] as Map<String, dynamic>,
);

Map<String, dynamic> _$GamificationEventDtoToJson(
  GamificationEventDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'created_at': instance.createdAt,
  'metadata': instance.metadata,
};

SyncGamificationEventsResultDto _$SyncGamificationEventsResultDtoFromJson(
  Map<String, dynamic> json,
) => SyncGamificationEventsResultDto(
  appliedCount: (json['applied_count'] as num).toInt(),
  duplicateSkippedCount: (json['duplicate_skipped_count'] as num).toInt(),
  dashboard: GamificationDashboardDto.fromJson(
    json['dashboard'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SyncGamificationEventsResultDtoToJson(
  SyncGamificationEventsResultDto instance,
) => <String, dynamic>{
  'applied_count': instance.appliedCount,
  'duplicate_skipped_count': instance.duplicateSkippedCount,
  'dashboard': instance.dashboard.toJson(),
};

GamificationEventRecordingResultDto
_$GamificationEventRecordingResultDtoFromJson(Map<String, dynamic> json) =>
    GamificationEventRecordingResultDto(
      dashboard: GamificationDashboardDto.fromJson(
        json['dashboard'] as Map<String, dynamic>,
      ),
      wasDuplicate: json['was_duplicate'] as bool,
    );

Map<String, dynamic> _$GamificationEventRecordingResultDtoToJson(
  GamificationEventRecordingResultDto instance,
) => <String, dynamic>{
  'dashboard': instance.dashboard.toJson(),
  'was_duplicate': instance.wasDuplicate,
};
