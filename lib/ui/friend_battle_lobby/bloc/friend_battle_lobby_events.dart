import 'package:quizcleandemo/data/game/domain/entities/game/game_room_entity.dart';

import '/data/game/domain/entities/game/invite_response_event_entity.dart';
import '/data/game/domain/entities/game/game_invite_entity.dart';
import '/data/game/domain/entities/game/game_player_entity.dart';

sealed class FriendBattleLobbyEvent {
  const FriendBattleLobbyEvent();
}

// Create room
class CreateFriendRoomEvent extends FriendBattleLobbyEvent {
  final String languageCode;
  final int totalRounds;

  const CreateFriendRoomEvent({
    required this.languageCode,
    this.totalRounds = 10,
  });
}

// Join existing room (when accepting invite)
class JoinExistingRoomEvent extends FriendBattleLobbyEvent {
  final String roomId;

  const JoinExistingRoomEvent({required this.roomId});
}

// Invite friend
class InviteFriendEvent extends FriendBattleLobbyEvent {
  final int friendId;
  const InviteFriendEvent(this.friendId);
}

// Start game
class StartGameEvent extends FriendBattleLobbyEvent {
  const StartGameEvent();
}

// Leave lobby
class LeaveLobbyEvent extends FriendBattleLobbyEvent {
  const LeaveLobbyEvent();
}

// SignalR events (internal)
class InviteSentReceived extends FriendBattleLobbyEvent {
  final GameInviteEntity invite;
  const InviteSentReceived(this.invite);
}

class InviteResponseReceived extends FriendBattleLobbyEvent {
  final InviteResponseEventEntity response;
  const InviteResponseReceived(this.response);
}

class PlayerJoinedLobby extends FriendBattleLobbyEvent {
  final GamePlayerEntity player;
  const PlayerJoinedLobby(this.player);
}

class PlayerLeftLobby extends FriendBattleLobbyEvent {
  final int userId;
  const PlayerLeftLobby(this.userId);
}

class RoomDataLoaded extends FriendBattleLobbyEvent {
  final GameRoomEntity room;
  const RoomDataLoaded(this.room);
}
