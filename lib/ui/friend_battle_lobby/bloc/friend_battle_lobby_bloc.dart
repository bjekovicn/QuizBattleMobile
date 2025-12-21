import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'friend_battle_lobby_events.dart';
import 'friend_battle_lobby_state.dart';
import '/data/game/domain/repositories/game_repository.dart';
import '/data/game/domain/updates/game_update.dart';
import '/data/game/domain/entities/game/invite_status.dart';
import '/data/auth/domain/repositories/auth_repository.dart';

@injectable
class FriendBattleLobbyBloc
    extends Bloc<FriendBattleLobbyEvent, FriendBattleLobbyState> {
  final GameRepository _gameRepository;
  final AuthRepository _authRepository;
  StreamSubscription<GameUpdate>? _gameUpdatesSub;

  FriendBattleLobbyBloc(
    this._gameRepository,
    this._authRepository,
  ) : super(const FriendBattleLobbyState()) {
    _subscribeToGameUpdates();

    on<CreateFriendRoomEvent>(_onCreateRoom);
    on<JoinExistingRoomEvent>(_onJoinExistingRoom);
    on<InviteFriendEvent>(_onInviteFriend);
    on<StartGameEvent>(_onStartGame);
    on<LeaveLobbyEvent>(_onLeaveLobby);
    on<InviteSentReceived>(_onInviteSent);
    on<RoomDataLoaded>(_onRoomDataLoaded);
    on<InviteResponseReceived>(_onInviteResponse);
    on<PlayerJoinedLobby>(_onPlayerJoined);
    on<PlayerLeftLobby>(_onPlayerLeft);
  }

  void _subscribeToGameUpdates() {
    _gameUpdatesSub = _gameRepository.updates.listen((update) {
      switch (update) {
        case RoomCreated(:final room):
          log('[FriendBattleLobby] Room data received: ${room.id}, players: ${room.players.length}');
          if (state.roomId == room.id) {
            add(RoomDataLoaded(room));
          }
        case InviteSent(:final invite):
          add(InviteSentReceived(invite));
        case InviteResponse(:final response):
          add(InviteResponseReceived(response));
        case PlayerJoined(:final player):
          add(PlayerJoinedLobby(player));
        case PlayerLeft(:final userId):
          add(PlayerLeftLobby(userId));
        default:
          break;
      }
    });
  }

  Future<void> _onCreateRoom(
    CreateFriendRoomEvent event,
    Emitter<FriendBattleLobbyState> emit,
  ) async {
    emit(state.copyWith(status: LobbyStatus.creating));

    // CRITICAL: Ensure SignalR is connected first!
    await _ensureConnected();

    final result = await _gameRepository.createFriendRoom(
      event.languageCode,
      event.totalRounds,
    );

    result.fold(
      (failure) {
        log('[FriendBattleLobby] Create room failed: ${failure.message}');
        emit(state.copyWith(
          status: LobbyStatus.error,
          errorMessage: failure.message,
        ));
      },
      (room) {
        if (room != null) {
          log('[FriendBattleLobby] Room created: ${room.id}');
          emit(state.copyWith(
            status: LobbyStatus.inLobby,
            roomId: room.id,
            hostUserId: room.hostPlayerId,
            players: room.players,
          ));
        }
      },
    );
  }

  void _onRoomDataLoaded(
    RoomDataLoaded event,
    Emitter<FriendBattleLobbyState> emit,
  ) {
    log('[FriendBattleLobby] Room data loaded: ${event.room.id}, host: ${event.room.hostPlayerId}, players: ${event.room.players.length}');

    emit(state.copyWith(
      roomId: event.room.id,
      hostUserId: event.room.hostPlayerId,
      players: event.room.players,
      status: LobbyStatus.inLobby,
    ));
  }

  Future<void> _onJoinExistingRoom(
    JoinExistingRoomEvent event,
    Emitter<FriendBattleLobbyState> emit,
  ) async {
    log('[FriendBattleLobby] Joining existing room: ${event.roomId}');
    emit(state.copyWith(
      status: LobbyStatus.creating,
      roomId: event.roomId,
    ));

    await _ensureConnected();

    // KRITIČNO: Pozovi joinRoom preko SignalR
    final joinResult = await _gameRepository.joinRoom(event.roomId);

    joinResult.fold(
      (failure) {
        log('[FriendBattleLobby] Join room failed: ${failure.message}');
        emit(state.copyWith(
          status: LobbyStatus.error,
          errorMessage: failure.message,
        ));
      },
      (_) {
        log('[FriendBattleLobby] Successfully joined room, waiting for room data...');
        emit(state.copyWith(status: LobbyStatus.inLobby));
      },
    );
  }

  Future<void> _ensureConnected() async {
    try {
      final authData = (await _authRepository.getStoredAuthData()).toNullable();

      if (authData == null) {
        log('[FriendBattleLobby] No auth data found');
        return;
      }

      // Connect to SignalR
      final connectResult = await _gameRepository.connect(authData.accessToken);

      connectResult.fold(
        (failure) => log(
          '[FriendBattleLobby] SignalR connect failed: ${failure.message}',
        ),
        (_) => log('[FriendBattleLobby] SignalR connected successfully'),
      );

      // Small delay to ensure connection is fully established
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      log('[FriendBattleLobby] Error ensuring connection: $e');
    }
  }

  Future<void> _onInviteFriend(
    InviteFriendEvent event,
    Emitter<FriendBattleLobbyState> emit,
  ) async {
    if (state.roomId == null) return;

    emit(state.copyWith(status: LobbyStatus.inviting));

    final result = await _gameRepository.inviteFriend(
      state.roomId!,
      event.friendId,
    );

    result.fold(
      (failure) {
        log('[FriendBattleLobby] Invite failed: ${failure.message}');
        emit(state.copyWith(
          status: LobbyStatus.inLobby,
          errorMessage: failure.message,
        ));
      },
      (_) {
        log('[FriendBattleLobby] Invite sent to friend: ${event.friendId}');
        emit(state.copyWith(status: LobbyStatus.inLobby));
      },
    );
  }

  Future<void> _onStartGame(
    StartGameEvent event,
    Emitter<FriendBattleLobbyState> emit,
  ) async {
    if (state.roomId == null || !state.canStartGame) return;

    emit(state.copyWith(status: LobbyStatus.starting));

    final result = await _gameRepository.startFriendBattle(state.roomId!);

    result.fold(
      (failure) {
        log('[FriendBattleLobby] Start game failed: ${failure.message}');
        emit(state.copyWith(
          status: LobbyStatus.inLobby,
          errorMessage: failure.message,
        ));
      },
      (_) {
        log('[FriendBattleLobby] Game starting...');
        // Stay in starting state, GameStarting event will handle navigation
      },
    );
  }

  Future<void> _onLeaveLobby(
    LeaveLobbyEvent event,
    Emitter<FriendBattleLobbyState> emit,
  ) async {
    if (state.roomId != null) {
      await _gameRepository.leaveRoom(state.roomId!);
    }
    await _gameRepository.disconnect();
    emit(const FriendBattleLobbyState());
  }

  void _onInviteSent(
    InviteSentReceived event,
    Emitter<FriendBattleLobbyState> emit,
  ) {
    log('[FriendBattleLobby] Invite sent: ${event.invite.invitedDisplayName}');

    final updatedInvites = [...state.invites, event.invite];

    emit(state.copyWith(
      invites: updatedInvites,
      status: LobbyStatus.inLobby,
    ));
  }

  void _onInviteResponse(
    InviteResponseReceived event,
    Emitter<FriendBattleLobbyState> emit,
  ) {
    log('[FriendBattleLobby] Invite response: ${event.response.friendName} ${event.response.accepted ? "accepted" : "rejected"}');

    final updatedInvites = state.invites.map((invite) {
      if (invite.invitedUserId == event.response.friendId) {
        return invite.copyWith(
          status: event.response.accepted
              ? InviteStatus.accepted
              : InviteStatus.rejected,
        );
      }
      return invite;
    }).toList();

    emit(state.copyWith(invites: updatedInvites));
  }

  void _onPlayerJoined(
    PlayerJoinedLobby event,
    Emitter<FriendBattleLobbyState> emit,
  ) {
    log('[FriendBattleLobby] Player joined: ${event.player.displayName}');

    // Check if player already exists (avoid duplicates)
    final playerExists =
        state.players.any((p) => p.userId == event.player.userId);
    if (playerExists) {
      log('[FriendBattleLobby] Player ${event.player.userId} already in list, skipping');
      return;
    }

    final updatedPlayers = [...state.players, event.player];

    // If we don't have hostUserId yet, assume first player is host
    final hostId = state.hostUserId ?? event.player.userId;

    emit(state.copyWith(
      players: updatedPlayers,
      hostUserId: hostId,
    ));
  }

  void _onPlayerLeft(
    PlayerLeftLobby event,
    Emitter<FriendBattleLobbyState> emit,
  ) {
    log('[FriendBattleLobby] Player left: ${event.userId}');

    final updatedPlayers =
        state.players.where((p) => p.userId != event.userId).toList();

    emit(state.copyWith(players: updatedPlayers));
  }

  @override
  Future<void> close() {
    _gameUpdatesSub?.cancel();
    return super.close();
  }
}
