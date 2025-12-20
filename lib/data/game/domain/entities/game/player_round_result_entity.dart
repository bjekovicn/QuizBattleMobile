class PlayerRoundResultEntity {
  final int userId;
  final String displayName;
  final String? answerGiven;
  final int? responseTimeMs;
  final int pointsAwarded;
  final bool isCorrect;

  const PlayerRoundResultEntity({
    required this.userId,
    required this.displayName,
    this.answerGiven,
    this.responseTimeMs,
    required this.pointsAwarded,
    required this.isCorrect,
  });

  bool get hasAnswered => answerGiven != null;

  Duration? get responseTime =>
      responseTimeMs != null ? Duration(milliseconds: responseTimeMs!) : null;

  PlayerRoundResultEntity copyWith({
    int? userId,
    String? displayName,
    String? answerGiven,
    int? responseTimeMs,
    int? pointsAwarded,
    bool? isCorrect,
  }) {
    return PlayerRoundResultEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      answerGiven: answerGiven ?? this.answerGiven,
      responseTimeMs: responseTimeMs ?? this.responseTimeMs,
      pointsAwarded: pointsAwarded ?? this.pointsAwarded,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerRoundResultEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'PlayerRoundResultEntity(userId: $userId, isCorrect: $isCorrect, points: $pointsAwarded)';
  }
}
