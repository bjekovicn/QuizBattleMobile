import 'game_player_entity.dart';
import 'game_question_entity.dart';

class GameRoomEntity {
  final String id;
  final int gameType;
  final int status;
  final String languageCode;
  final int totalRounds;
  final int currentRound;
  final int? hostPlayerId;
  final int createdAt;
  final int? startedAt;
  final int? roundStartedAt;
  final int? roundEndsAt;
  final List<GamePlayerEntity> players;
  final List<GameQuestionEntity> questions;

  const GameRoomEntity({
    required this.id,
    required this.gameType,
    required this.status,
    required this.languageCode,
    required this.totalRounds,
    required this.currentRound,
    this.hostPlayerId,
    required this.createdAt,
    this.startedAt,
    this.roundStartedAt,
    this.roundEndsAt,
    required this.players,
    required this.questions,
  });

  bool isHost(int userId) => hostPlayerId == userId;

  bool get canStart => players.length >= 2 && players.every((p) => p.isReady);

  int? getRemainingTimeMs() {
    if (roundEndsAt == null) return null;
    final now = DateTime.now().millisecondsSinceEpoch;
    final remaining = roundEndsAt! - now;
    return remaining > 0 ? remaining : 0;
  }

  GameRoomEntity copyWith({
    String? id,
    int? gameType,
    int? status,
    String? languageCode,
    int? totalRounds,
    int? currentRound,
    int? hostPlayerId,
    int? createdAt,
    int? startedAt,
    int? roundStartedAt,
    int? roundEndsAt,
    List<GamePlayerEntity>? players,
    List<GameQuestionEntity>? questions,
  }) {
    return GameRoomEntity(
      id: id ?? this.id,
      gameType: gameType ?? this.gameType,
      status: status ?? this.status,
      languageCode: languageCode ?? this.languageCode,
      totalRounds: totalRounds ?? this.totalRounds,
      currentRound: currentRound ?? this.currentRound,
      hostPlayerId: hostPlayerId ?? this.hostPlayerId,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      roundStartedAt: roundStartedAt ?? this.roundStartedAt,
      roundEndsAt: roundEndsAt ?? this.roundEndsAt,
      players: players ?? this.players,
      questions: questions ?? this.questions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameRoomEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'GameRoomEntity(id: $id, status: $status, players: ${players.length}, currentRound: $currentRound/$totalRounds)';
  }
}
