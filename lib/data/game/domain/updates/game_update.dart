import '../entities/game/game_player_entity.dart';
import '../entities/game/game_room_entity.dart';
import '../entities/game/game_result_entity.dart';
import '../entities/game/round_result_entity.dart';
import '../entities/game/round_started_event_entity.dart';
import '../entities/game/match_found_event_entity.dart';
import '../entities/game/matchmaking_update_entity.dart';

/// Base class for all game updates received from SignalR
sealed class GameUpdate {
  const GameUpdate();
}

/// Room was created
class RoomCreated extends GameUpdate {
  final GameRoomEntity room;
  const RoomCreated(this.room);
}

/// Player joined the room
class PlayerJoined extends GameUpdate {
  final GamePlayerEntity player;
  const PlayerJoined(this.player);
}

/// Player left the room
class PlayerLeft extends GameUpdate {
  final int userId;
  const PlayerLeft(this.userId);
}

/// Player ready status changed
class PlayerReadyChanged extends GameUpdate {
  final int userId;
  final bool ready;
  const PlayerReadyChanged(this.userId, this.ready);
}

/// Player disconnected from the room
class PlayerDisconnected extends GameUpdate {
  final int userId;
  const PlayerDisconnected(this.userId);
}

/// Player reconnected to the room
class PlayerReconnected extends GameUpdate {
  final int userId;
  const PlayerReconnected(this.userId);
}

/// Game is starting (countdown before first round)
class GameStarting extends GameUpdate {
  final GameRoomEntity room;
  const GameStarting(this.room);
}

/// Round started with new question
class RoundStarted extends GameUpdate {
  final RoundStartedEventEntity event;
  const RoundStarted(this.event);
}

/// Player submitted an answer
class PlayerAnswered extends GameUpdate {
  final int userId;
  const PlayerAnswered(this.userId);
}

/// Round ended with results
class RoundEnded extends GameUpdate {
  final RoundResultEntity result;
  const RoundEnded(this.result);
}

/// Game ended with final results
class GameEnded extends GameUpdate {
  final GameResultEntity result;
  const GameEnded(this.result);
}

/// Match found in matchmaking queue
class MatchFound extends GameUpdate {
  final MatchFoundEventEntity event;
  const MatchFound(this.event);
}

/// Matchmaking queue position updated
class MatchmakingUpdated extends GameUpdate {
  final MatchmakingUpdateEventEntity event;
  const MatchmakingUpdated(this.event);
}

/// Error received from SignalR
class GameErrorUpdate extends GameUpdate {
  final String code;
  final String message;
  const GameErrorUpdate(this.code, this.message);
}
