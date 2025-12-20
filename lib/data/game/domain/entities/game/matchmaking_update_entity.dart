class MatchmakingUpdateEventEntity {
  final int queuePosition;
  final int playersInQueue;

  const MatchmakingUpdateEventEntity({
    required this.queuePosition,
    required this.playersInQueue,
  });

  MatchmakingUpdateEventEntity copyWith({
    int? queuePosition,
    int? playersInQueue,
  }) {
    return MatchmakingUpdateEventEntity(
      queuePosition: queuePosition ?? this.queuePosition,
      playersInQueue: playersInQueue ?? this.playersInQueue,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchmakingUpdateEventEntity &&
          runtimeType == other.runtimeType &&
          queuePosition == other.queuePosition;

  @override
  int get hashCode => queuePosition.hashCode;
}
