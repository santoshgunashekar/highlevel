/// PRD `Challenge`.
final class Challenge {
  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.rewardXp,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;
  final int rewardXp;
  final bool isCompleted;

  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    int? progress,
    int? target,
    int? rewardXp,
    bool? isCompleted,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      rewardXp: rewardXp ?? this.rewardXp,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
