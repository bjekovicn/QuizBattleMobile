import 'dart:async';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:quizcleandemo/data/game/data/data_sources/remote/rest/game_invite_api_service.dart';
import 'package:quizcleandemo/data/game/data/models/signalr/game_invite_model.dart';
import 'package:quizcleandemo/data/game/data/models/signalr/invite_response_event_model.dart';

import '/core/error_handling/failure.dart';
import '/core/constants/game_hub_event.dart';
import '/core/constants/game_hub_method.dart';
import '/data/game/domain/updates/game_update.dart';
import '/data/game/data/mappers/signalr/game_room_mapper.dart';
import '/data/game/data/mappers/signalr/game_player_mapper.dart';
import '/data/game/data/mappers/signalr/game_result_mapper.dart';
import '../data_sources/remote/signalr/game_hub_service.dart';
import '/data/game/data/mappers/signalr/round_result_mapper.dart';
import '/data/game/data/mappers/signalr/round_started_event_mapper.dart';
import '/data/game/data/mappers/signalr/match_found_event_mapper.dart';
import '/data/game/data/mappers/signalr/matchmaking_update_event_mapper.dart';
import '/data/game/data/models/signalr/game_player_model.dart';
import '/data/game/data/models/signalr/game_result_model.dart';
import '/data/game/data/models/signalr/game_room_model.dart';
import '/data/game/data/models/signalr/round_result_model.dart';
import '/data/game/data/models/signalr/round_started_event_model.dart';
import '/data/game/data/models/signalr/match_found_event_model.dart';
import '/data/game/data/models/signalr/matchmaking_update_event_model.dart';
import '/data/game/domain/entities/game/game_room_entity.dart';
import '/data/game/domain/repositories/game_repository.dart';

@LazySingleton(as: GameRepository)
class GameRepositoryImpl implements GameRepository {
  final GameHubService _hub;
  final GameInviteApiService _inviteApiService;
  final _controller = StreamController<GameUpdate>.broadcast();
  bool _handlersRegistered = false;

  GameRepositoryImpl(this._hub, this._inviteApiService);

  void _registerEventHandlers() {
    if (_handlersRegistered) {
      log('[GameRepository] Event handlers already registered, skipping...');
      return;
    }

    log('[GameRepository] Registering event handlers...');

    // Room Events
    _hub.on<GameRoomModel>(
      GameHubEvent.roomCreated.eventName,
      GameRoomModel.fromJson,
      (model) {
        log('[GameRepository] RoomCreated event received');
        _controller.add(RoomCreated(model.toEntity()));
      },
    );

    _hub.on<GamePlayerModel>(
      GameHubEvent.playerJoined.eventName,
      GamePlayerModel.fromJson,
      (model) {
        log('[GameRepository] PlayerJoined event received: ${model.displayName}');
        _controller.add(PlayerJoined(model.toEntity()));
      },
    );

    _hub.onArgs<int, void>(
      GameHubEvent.playerLeft.eventName,
      (userId, _) {
        log('[GameRepository] PlayerLeft event received: $userId');
        _controller.add(PlayerLeft(userId));
      },
    );

    _hub.onArgs<int, bool>(
      GameHubEvent.playerReadyChanged.eventName,
      (userId, ready) {
        log('[GameRepository] PlayerReadyChanged event received: $userId = $ready');
        _controller.add(PlayerReadyChanged(userId, ready));
      },
    );

    _hub.onArgs<int, void>(
      GameHubEvent.playerDisconnected.eventName,
      (userId, _) {
        log('[GameRepository] PlayerDisconnected event received: $userId');
        _controller.add(PlayerDisconnected(userId));
      },
    );

    _hub.onArgs<int, void>(
      GameHubEvent.playerReconnected.eventName,
      (userId, _) {
        log('[GameRepository] PlayerReconnected event received: $userId');
        _controller.add(PlayerReconnected(userId));
      },
    );

    // Game Flow Events
    _hub.on<GameRoomModel>(
      GameHubEvent.gameStarting.eventName,
      GameRoomModel.fromJson,
      (model) {
        log('[GameRepository] GameStarting event received');
        _controller.add(GameStarting(model.toEntity()));
      },
    );

    _hub.on<RoundStartedEventModel>(
      GameHubEvent.roundStarted.eventName,
      RoundStartedEventModel.fromJson,
      (model) {
        log('[GameRepository] RoundStarted event received');
        _controller.add(RoundStarted(model.toEntity()));
      },
    );

    _hub.onArgs<int, void>(
      GameHubEvent.playerAnswered.eventName,
      (userId, _) {
        log('[GameRepository] PlayerAnswered event received: $userId');
        _controller.add(PlayerAnswered(userId));
      },
    );

    _hub.on<RoundResultModel>(
      GameHubEvent.roundEnded.eventName,
      RoundResultModel.fromJson,
      (model) {
        log('[GameRepository] RoundEnded event received');
        _controller.add(RoundEnded(model.toEntity()));
      },
    );

    _hub.on<GameResultModel>(
      GameHubEvent.gameEnded.eventName,
      GameResultModel.fromJson,
      (model) {
        log('[GameRepository] GameEnded event received');
        _controller.add(GameEnded(model.toEntity()));
      },
    );

    // Matchmaking Events
    _hub.on<MatchFoundEventModel>(
      GameHubEvent.matchFound.eventName,
      MatchFoundEventModel.fromJson,
      (model) {
        log('[GameRepository] MatchFound event received: ${model.roomId}');
        _controller.add(MatchFound(model.toEntity()));
      },
    );

    _hub.on<MatchmakingUpdateEventModel>(
      GameHubEvent.matchmakingUpdate.eventName,
      MatchmakingUpdateEventModel.fromJson,
      (model) {
        log('[GameRepository] MatchmakingUpdate event received: pos=${model.queuePosition}');
        _controller.add(MatchmakingUpdated(model.toEntity()));
      },
    );

    // Error Events
    _hub.onArgs<String, String>(
      GameHubEvent.error.eventName,
      (code, message) {
        log('[GameRepository] Error event received: $code - $message');
        _controller.add(GameErrorUpdate(code, message));
      },
    );

    _hub.on<GameInviteModel>(
      GameHubEvent.inviteSent.eventName,
      GameInviteModel.fromJson,
      (model) {
        log('[GameRepository] InviteSent event received');
        _controller.add(InviteSent(model.toEntity()));
      },
    );

    _hub.on<GameInviteModel>(
      GameHubEvent.inviteReceived.eventName,
      GameInviteModel.fromJson,
      (model) {
        log('[GameRepository] InviteReceived event received');
        _controller.add(InviteReceived(model.toEntity()));
      },
    );

    _hub.on<InviteResponseEventModel>(
      GameHubEvent.inviteResponse.eventName,
      InviteResponseEventModel.fromJson,
      (model) {
        log('[GameRepository] InviteResponse event received: ${model.friendName} ${model.accepted ? "accepted" : "rejected"}');
        _controller.add(InviteResponse(model.toEntity()));
      },
    );

    _handlersRegistered = true;
    log('[GameRepository] All event handlers registered');
  }

  @override
  Stream<GameUpdate> get updates => _controller.stream;

  @override
  Future<Either<Failure, void>> connect(String accessToken) async {
    log('[GameRepository] Connecting to SignalR...');

    _registerEventHandlers();

    final result = await _hub.connect(accessToken);

    if (result.isLeft()) {
      log('[GameRepository] Connection failed');
    } else {
      log('[GameRepository] Connected successfully, event handlers ready');
    }

    return result;
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    log('[GameRepository] Disconnecting from SignalR...');
    return await _hub.disconnect();
  }

  @override
  Future<Either<Failure, void>> joinMatchmaking(
    int gameType,
    String languageCode,
  ) {
    log('[GameRepository] Calling joinMatchmaking: gameType=$gameType, lang=$languageCode');
    return _hub.invoke<void>(
      GameHubMethod.joinMatchmaking.methodName,
      args: [gameType, languageCode],
    );
  }

  @override
  Future<Either<Failure, void>> leaveMatchmaking(
    int gameType,
    String languageCode,
  ) {
    log('[GameRepository] Calling leaveMatchmaking');
    return _hub.invoke<void>(
      GameHubMethod.leaveMatchmaking.methodName,
      args: [gameType, languageCode],
    );
  }

  @override
  Future<Either<Failure, GameRoomEntity?>> createRoom(
    int gameType,
    String languageCode,
    int rounds,
  ) {
    log('[GameRepository] Calling createRoom');
    return _hub.invoke<GameRoomEntity>(
      GameHubMethod.createRoom.methodName,
      args: [gameType, languageCode, rounds],
      fromJson: (json) => GameRoomModel.fromJson(json).toEntity(),
    );
  }

  @override
  Future<Either<Failure, void>> leaveRoom(String roomId) {
    log('[GameRepository] Calling leaveRoom');
    return _hub.invoke<void>(
      GameHubMethod.leaveRoom.methodName,
      args: [roomId],
    );
  }

  @override
  Future<Either<Failure, void>> setReady(String roomId, bool ready) {
    log('[GameRepository] Calling setReady: $ready');
    return _hub.invoke<void>(
      GameHubMethod.setReady.methodName,
      args: [roomId, ready],
    );
  }

  @override
  Future<Either<Failure, void>> submitAnswer(String roomId, String answer) {
    log('[GameRepository] Calling submitAnswer: $answer');
    return _hub.invoke<void>(
      GameHubMethod.submitAnswer.methodName,
      args: [roomId, answer],
    );
  }

  @override
  Future<Either<Failure, GameRoomEntity?>> createFriendRoom(
    String languageCode,
    int totalRounds,
  ) {
    log('[GameRepository] Calling createFriendRoom: lang=$languageCode, rounds=$totalRounds');
    return _hub.invoke<GameRoomEntity>(
      GameHubMethod.createFriendRoom.methodName,
      args: [languageCode, totalRounds],
      fromJson: (json) => GameRoomModel.fromJson(json).toEntity(),
    );
  }

  @override
  Future<Either<Failure, void>> inviteFriend(
    String roomId,
    int friendId,
  ) {
    log('[GameRepository] Calling inviteFriend: roomId=$roomId, friendId=$friendId');
    return _hub.invoke<void>(
      GameHubMethod.inviteFriend.methodName,
      args: [roomId, friendId],
    );
  }

  @override
  Future<Either<Failure, String?>> respondToInvite(
    String inviteId,
    bool accept,
  ) async {
    try {
      final res = await _inviteApiService.respondToInvite(
        inviteId,
        {'accept': accept},
      );

      final data = res.data;

      return Right(data.accepted ? data.roomId : null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, void>> startFriendBattle(String roomId) {
    log('[GameRepository] Calling startFriendBattle: roomId=$roomId');
    return _hub.invoke<void>(
      GameHubMethod.startFriendBattle.methodName,
      args: [roomId],
    );
  }

  @override
  Future<Either<Failure, void>> joinRoom(String roomId) {
    log('[GameRepository] Calling joinRoom: roomId=$roomId');
    return _hub.invoke<void>(
      GameHubMethod.joinRoom.methodName,
      args: [roomId],
    );
  }

  void dispose() {
    log('[GameRepository] Disposing...');
    _controller.close();
  }
}
