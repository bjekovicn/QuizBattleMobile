import '/data/game/domain/updates/game_update.dart';

sealed class GameEvent {
  const GameEvent();
}

// Connection Events
class ConnectEvent extends GameEvent {
  final JoinMatchmakingEvent? pendingMatchmaking;

  const ConnectEvent({this.pendingMatchmaking});
}

class DisconnectEvent extends GameEvent {
  const DisconnectEvent();
}

// Matchmaking Events
class JoinMatchmakingEvent extends GameEvent {
  final int gameType;
  final String languageCode;

  const JoinMatchmakingEvent({
    required this.gameType,
    required this.languageCode,
  });
}

class LeaveMatchmakingEvent extends GameEvent {
  const LeaveMatchmakingEvent();
}

// Room Events
class JoinRoomEvent extends GameEvent {
  final String roomId;
  const JoinRoomEvent(this.roomId);
}

class SetReadyEvent extends GameEvent {
  final bool isReady;
  const SetReadyEvent(this.isReady);
}

// Gameplay Events
class SubmitAnswerEvent extends GameEvent {
  final String answer;
  const SubmitAnswerEvent(this.answer);
}

// Internal Event (from SignalR)
class GameUpdated extends GameEvent {
  final GameUpdate update;
  const GameUpdated(this.update);
}
