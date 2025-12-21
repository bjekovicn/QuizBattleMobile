import '/data/game/domain/entities/game/game_invite_entity.dart';
import '/data/game/domain/entities/game/game_player_entity.dart';

enum LobbyStatus { initial, creating, inLobby, inviting, starting, error }

class FriendBattleLobbyState {
  final LobbyStatus status;
  final String? roomId;
  final int? hostUserId;
  final List<GamePlayerEntity> players;
  final List<GameInviteEntity> invites;
  final String? errorMessage;

  const FriendBattleLobbyState({
    this.status = LobbyStatus.initial,
    this.roomId,
    this.hostUserId,
    this.players = const [],
    this.invites = const [],
    this.errorMessage,
  });

  FriendBattleLobbyState copyWith({
    LobbyStatus? status,
    String? roomId,
    int? hostUserId,
    List<GamePlayerEntity>? players,
    List<GameInviteEntity>? invites,
    String? errorMessage,
  }) {
    return FriendBattleLobbyState(
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      hostUserId: hostUserId ?? this.hostUserId,
      players: players ?? this.players,
      invites: invites ?? this.invites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isHost => hostUserId != null;
  bool get canStartGame => players.isNotEmpty;
  int get pendingInvitesCount => invites.where((i) => i.isPending).length;
  int get acceptedInvitesCount => invites.where((i) => i.isAccepted).length;
}
