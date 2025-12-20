class MatchedPlayerEntity {
  final int userId;
  final String displayName;
  final String? photoUrl;

  const MatchedPlayerEntity({
    required this.userId,
    required this.displayName,
    this.photoUrl,
  });

  MatchedPlayerEntity copyWith({
    int? userId,
    String? displayName,
    String? photoUrl,
  }) {
    return MatchedPlayerEntity(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchedPlayerEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;
}
