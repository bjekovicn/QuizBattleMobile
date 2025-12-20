class PlayerScoreEntity {
  final int userId;
  final String displayName;
  final int totalScore;

  const PlayerScoreEntity({
    required this.userId,
    required this.displayName,
    required this.totalScore,
  });

  PlayerScoreEntity copyWith({
    int? userId,
    String? displayName,
    int? totalScore,
  }) {
    return PlayerScoreEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      totalScore: totalScore ?? this.totalScore,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerScoreEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'PlayerScoreEntity(userId: $userId, displayName: $displayName, totalScore: $totalScore)';
  }
}
