class FinalStandingEntity {
  final int position;
  final int userId;
  final String displayName;
  final String? photoUrl;
  final int totalScore;
  final String colorHex;

  const FinalStandingEntity({
    required this.position,
    required this.userId,
    required this.displayName,
    this.photoUrl,
    required this.totalScore,
    required this.colorHex,
  });

  bool get isWinner => position == 1;

  bool get isOnPodium => position <= 3;

  FinalStandingEntity copyWith({
    int? position,
    int? userId,
    String? displayName,
    String? photoUrl,
    int? totalScore,
    String? colorHex,
  }) {
    return FinalStandingEntity(
      position: position ?? this.position,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      totalScore: totalScore ?? this.totalScore,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinalStandingEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'FinalStandingEntity(#$position: $displayName, score: $totalScore)';
  }
}
