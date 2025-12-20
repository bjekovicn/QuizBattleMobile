class PlayerRoundScoreEntity {
  final int userId;
  final String displayName;
  final int roundScore;
  final int totalScore;
  final bool wasCorrect;

  const PlayerRoundScoreEntity({
    required this.userId,
    required this.displayName,
    required this.roundScore,
    required this.totalScore,
    required this.wasCorrect,
  });

  PlayerRoundScoreEntity copyWith({
    int? userId,
    String? displayName,
    int? roundScore,
    int? totalScore,
    bool? wasCorrect,
  }) {
    return PlayerRoundScoreEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      roundScore: roundScore ?? this.roundScore,
      totalScore: totalScore ?? this.totalScore,
      wasCorrect: wasCorrect ?? this.wasCorrect,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerRoundScoreEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
