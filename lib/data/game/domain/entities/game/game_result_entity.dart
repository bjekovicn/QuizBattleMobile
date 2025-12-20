import 'final_standing_entity.dart';

class GameResultEntity {
  final String gameRoomId;
  final int gameType;
  final int totalRounds;
  final int? winnerUserId;
  final List<FinalStandingEntity> finalStandings;
  final int? startedAt;
  final int endedAt;

  const GameResultEntity({
    required this.gameRoomId,
    required this.gameType,
    required this.totalRounds,
    this.winnerUserId,
    required this.finalStandings,
    this.startedAt,
    required this.endedAt,
  });

  FinalStandingEntity? get winner =>
      finalStandings.isNotEmpty ? finalStandings.first : null;

  List<FinalStandingEntity> get podium => finalStandings.take(3).toList();

  bool isWinner(int userId) => winnerUserId == userId;

  int? get gameDurationMs {
    if (startedAt == null) return null;
    return endedAt - startedAt!;
  }

  Duration? get gameDuration {
    final ms = gameDurationMs;
    return ms != null ? Duration(milliseconds: ms) : null;
  }

  DateTime? get startedAtDateTime => startedAt != null
      ? DateTime.fromMillisecondsSinceEpoch(startedAt!)
      : null;

  DateTime get endedAtDateTime => DateTime.fromMillisecondsSinceEpoch(endedAt);

  GameResultEntity copyWith({
    String? gameRoomId,
    int? gameType,
    int? totalRounds,
    int? winnerUserId,
    List<FinalStandingEntity>? finalStandings,
    int? startedAt,
    int? endedAt,
  }) {
    return GameResultEntity(
      gameRoomId: gameRoomId ?? this.gameRoomId,
      gameType: gameType ?? this.gameType,
      totalRounds: totalRounds ?? this.totalRounds,
      winnerUserId: winnerUserId ?? this.winnerUserId,
      finalStandings: finalStandings ?? this.finalStandings,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameResultEntity &&
          runtimeType == other.runtimeType &&
          gameRoomId == other.gameRoomId;

  @override
  int get hashCode => gameRoomId.hashCode;

  @override
  String toString() {
    return 'GameResultEntity(roomId: $gameRoomId, winner: $winnerUserId, rounds: $totalRounds)';
  }
}
