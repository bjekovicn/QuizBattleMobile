import '/core/error_handling/failure.dart';
import '/data/game/domain/entities/game/game_room_entity.dart';
import '/data/game/domain/entities/game/game_result_entity.dart';
import '/data/game/domain/entities/game/round_result_entity.dart';
import '/data/game/domain/entities/game/round_started_event_entity.dart';

class GameState {
  // User state
  final int? currentUserId;

  // Room state
  final GameRoomEntity? room;
  final RoundStartedEventEntity? activeRound;
  final RoundResultEntity? roundResult;
  final GameResultEntity? gameResult;

  // Player state
  final Set<int> answeredPlayers;
  final bool hasAnswered;
  final String? selectedAnswer;

  // Matchmaking state
  final int? queuePosition;
  final int? playersInQueue;

  // UI state
  final GameStatus status;
  final Failure? error;

  const GameState({
    this.currentUserId,
    this.room,
    this.activeRound,
    this.roundResult,
    this.gameResult,
    this.answeredPlayers = const {},
    this.hasAnswered = false,
    this.selectedAnswer,
    this.queuePosition,
    this.playersInQueue,
    this.status = GameStatus.idle,
    this.error,
  });

  GameState copyWith({
    int? currentUserId,
    GameRoomEntity? room,
    RoundStartedEventEntity? activeRound,
    RoundResultEntity? roundResult,
    GameResultEntity? gameResult,
    Set<int>? answeredPlayers,
    bool? hasAnswered,
    String? selectedAnswer,
    int? queuePosition,
    int? playersInQueue,
    GameStatus? status,
    Failure? error,
  }) {
    return GameState(
      currentUserId: currentUserId ?? this.currentUserId,
      room: room ?? this.room,
      activeRound: activeRound ?? this.activeRound,
      roundResult: roundResult ?? this.roundResult,
      gameResult: gameResult ?? this.gameResult,
      answeredPlayers: answeredPlayers ?? this.answeredPlayers,
      hasAnswered: hasAnswered ?? this.hasAnswered,
      selectedAnswer: selectedAnswer,
      queuePosition: queuePosition ?? this.queuePosition,
      playersInQueue: playersInQueue ?? this.playersInQueue,
      status: status ?? this.status,
      error: error,
    );
  }
}

enum GameStatus {
  idle,
  matchmaking,
  lobby,
  starting,
  roundActive,
  roundResult,
  finished,
}
