class FinalPlayerScoreEntity {
  final int userId;
  final String displayName;
  final int totalScore;
  final int rank;

  const FinalPlayerScoreEntity({
    required this.userId,
    required this.displayName,
    required this.totalScore,
    required this.rank,
  });

  FinalPlayerScoreEntity copyWith({
    int? userId,
    String? displayName,
    int? totalScore,
    int? rank,
  }) {
    return FinalPlayerScoreEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      totalScore: totalScore ?? this.totalScore,
      rank: rank ?? this.rank,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinalPlayerScoreEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
