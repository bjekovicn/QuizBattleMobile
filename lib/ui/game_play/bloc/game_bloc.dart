import 'dart:async'; // ✅ Add this import
import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_events.dart';
import 'game_states.dart';
import '/core/error_handling/failure.dart';
import '/data/game/domain/updates/game_update.dart';
import '/data/game/domain/repositories/game_repository.dart';
import '/data/auth/domain/repositories/auth_repository.dart';
import '/data/game/domain/entities/game/game_room_entity.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repo;
  final AuthRepository _auth;
  StreamSubscription<GameUpdate>? _updateSubscription;

  GameBloc(this._repo, this._auth) : super(const GameState()) {
    on<ConnectEvent>(_onConnect);
    on<JoinMatchmakingEvent>(_onJoinMatchmaking);
    on<LeaveMatchmakingEvent>(_onLeaveMatchmaking);
    on<SetReadyEvent>(_onSetReady);
    on<SubmitAnswerEvent>(_onSubmitAnswer);
    on<GameUpdated>(_onUpdate);

    _updateSubscription = _repo.updates.listen(
      (update) {
        if (!isClosed) {
          add(GameUpdated(update));
        }
      },
      onError: (e, stackTrace) {
        if (!isClosed) {
          log('[GameBloc] Update stream error: $e', stackTrace: stackTrace);
        }
      },
    );
  }

  Future<void> _onConnect(ConnectEvent event, Emitter<GameState> emit) async {
    try {
      final userId = await _auth.getUserIdFromToken();
      final authData = (await _auth.getStoredAuthData()).toNullable();

      if (authData == null || userId == null) {
        log('[GameBloc] Auth data or userId is null');
        return;
      }

      final result = await _repo.connect(authData.accessToken);

      result.fold(
        (failure) {
          log('[GameBloc] Connection failed: ${failure.message}');
          emit(state.copyWith(error: failure));
        },
        (_) async {
          log('[GameBloc] Connected successfully, userId: $userId');
          emit(state.copyWith(currentUserId: userId));

          if (event.pendingMatchmaking != null) {
            await Future.delayed(const Duration(seconds: 1));
            add(event.pendingMatchmaking!);
          }
        },
      );
    } catch (e, stackTrace) {
      log('[GameBloc] Connect error: $e', stackTrace: stackTrace);
      emit(state.copyWith(error: Failure(500, e.toString())));
    }
  }

  Future<void> _onJoinMatchmaking(
    JoinMatchmakingEvent event,
    Emitter<GameState> emit,
  ) async {
    try {
      log(
        '[GameBloc] Joining matchmaking: gameType=${event.gameType}, lang=${event.languageCode}',
      );

      emit(state.copyWith(status: GameStatus.matchmaking));

      final result = await _repo.joinMatchmaking(
        event.gameType,
        event.languageCode,
      );

      result.fold(
        (failure) {
          log('[GameBloc] Join matchmaking failed: ${failure.message}');
          emit(state.copyWith(error: failure, status: GameStatus.idle));
        },
        (_) {
          log('[GameBloc] Join matchmaking success');
        },
      );
    } catch (e, stackTrace) {
      log('[GameBloc] Join matchmaking error: $e', stackTrace: stackTrace);
      emit(
        state.copyWith(
          error: Failure(500, e.toString()),
          status: GameStatus.idle,
        ),
      );
    }
  }

  Future<void> _onLeaveMatchmaking(
    LeaveMatchmakingEvent event,
    Emitter<GameState> emit,
  ) async {
    // Will implement if needed
  }

  Future<void> _onSetReady(SetReadyEvent event, Emitter<GameState> emit) async {
    if (state.room == null) return;

    try {
      log('[GameBloc] Setting ready: ${event.isReady}');

      final result = await _repo.setReady(state.room!.id, event.isReady);

      result.fold(
        (failure) {
          log('[GameBloc] Set ready failed: ${failure.message}');
          emit(state.copyWith(error: failure));
        },
        (_) {
          log('[GameBloc] Set ready success');
        },
      );
    } catch (e, stackTrace) {
      log('[GameBloc] Set ready error: $e', stackTrace: stackTrace);
      emit(state.copyWith(error: Failure(500, e.toString())));
    }
  }

  Future<void> _onSubmitAnswer(
    SubmitAnswerEvent event,
    Emitter<GameState> emit,
  ) async {
    if (state.hasAnswered || state.room == null) return;

    try {
      log('[GameBloc] Submitting answer: ${event.answer}');

      emit(state.copyWith(hasAnswered: true, selectedAnswer: event.answer));

      final result = await _repo.submitAnswer(state.room!.id, event.answer);

      result.fold(
        (failure) {
          log('[GameBloc] Submit answer failed: ${failure.message}');
          emit(state.copyWith(
              error: failure, hasAnswered: false, selectedAnswer: null));
        },
        (_) {
          log('[GameBloc] Submit answer success');
        },
      );
    } catch (e, stackTrace) {
      log('[GameBloc] Submit answer error: $e', stackTrace: stackTrace);
      emit(state.copyWith(
          error: Failure(500, e.toString()),
          hasAnswered: false,
          selectedAnswer: null));
    }
  }

  void _onUpdate(GameUpdated event, Emitter<GameState> emit) {
    try {
      log('[GameBloc] Received update: ${event.update.runtimeType}');

      switch (event.update) {
        // Matchmaking Events
        case MatchmakingUpdated(:final event):
          log(
            '[GameBloc] Matchmaking updated: pos=${event.queuePosition}, queue=${event.playersInQueue}',
          );
          emit(
            state.copyWith(
              status: GameStatus.matchmaking,
              queuePosition: event.queuePosition,
              playersInQueue: event.playersInQueue,
            ),
          );

        case MatchFound(:final event):
          log('[GameBloc] Match found! RoomId: ${event.roomId}');
          log('[GameBloc] Players in match: ${event.players.length}');
          log('[GameBloc] Waiting for RoomCreated event...');

          emit(
            state.copyWith(
              status: GameStatus.matchmaking,
              queuePosition: null,
              playersInQueue: null,
            ),
          );

        // Room Events
        case RoomCreated(:final room):
          log('[GameBloc] Room created: ${room.id}');
          log('[GameBloc] Room has ${room.players.length} players');

          emit(state.copyWith(
            room: room,
            status: GameStatus.lobby,
          ));

        case PlayerJoined(:final player):
          if (state.room == null) return;
          log('[GameBloc] Player joined: ${player.displayName}');

          final updatedPlayers = [...state.room!.players, player];
          final updatedRoom = state.room!.copyWith(players: updatedPlayers);

          emit(state.copyWith(room: updatedRoom));

        case PlayerLeft(:final userId):
          if (state.room == null) return;
          log('[GameBloc] Player left: $userId');

          final updatedPlayers = state.room!.players.where((p) {
            return p.userId != userId;
          }).toList();
          final updatedRoom = state.room!.copyWith(players: updatedPlayers);

          emit(state.copyWith(room: updatedRoom));

        case PlayerReadyChanged(:final userId, :final ready):
          if (state.room == null) return;
          log('[GameBloc] Player ready changed: $userId = $ready');

          final updatedPlayers = state.room!.players.map((p) {
            return p.userId == userId ? p.copyWith(isReady: ready) : p;
          }).toList();
          final updatedRoom = state.room!.copyWith(players: updatedPlayers);

          emit(state.copyWith(room: updatedRoom));

        case PlayerDisconnected(:final userId):
          if (state.room == null) return;
          log('[GameBloc] Player disconnected: $userId');

          final updatedPlayers = state.room!.players.map((p) {
            return p.userId == userId ? p.copyWith(isConnected: false) : p;
          }).toList();
          final updatedRoom = state.room!.copyWith(players: updatedPlayers);

          emit(state.copyWith(room: updatedRoom));

        case PlayerReconnected(:final userId):
          if (state.room == null) return;
          log('[GameBloc] Player reconnected: $userId');

          final updatedPlayers = state.room!.players.map((p) {
            return p.userId == userId ? p.copyWith(isConnected: true) : p;
          }).toList();
          final updatedRoom = state.room!.copyWith(players: updatedPlayers);

          emit(state.copyWith(room: updatedRoom));

        // Game Flow Events
        case GameStarting(:final room):
          log('[GameBloc] Game starting!');
          emit(state.copyWith(room: room, status: GameStatus.starting));

        case RoundStarted(:final event):
          log(
            '[GameBloc] Round started: ${event.currentRound}/${event.totalRounds}',
          );

          GameRoomEntity? updatedRoom = state.room;
          if (state.room != null) {
            log('[GameBloc] Question received: ${event.question.text}');
          }

          emit(
            state.copyWith(
              room: updatedRoom,
              activeRound: event,
              answeredPlayers: {},
              hasAnswered: false,
              selectedAnswer: null,
              status: GameStatus.roundActive,
            ),
          );

        case PlayerAnswered(:final userId):
          log('[GameBloc] Player answered: $userId');
          emit(
            state.copyWith(answeredPlayers: {...state.answeredPlayers, userId}),
          );

        case RoundEnded(:final result):
          log('[GameBloc] Round ended: ${result.roundNumber}');

          GameRoomEntity? updatedRoom = state.room;
          if (state.room != null && result.currentStandings.isNotEmpty) {
            log('[GameBloc] Updating player scores from currentStandings');

            final updatedPlayers = state.room!.players.map((player) {
              final standing = result.currentStandings.firstWhere(
                (s) => s.userId == player.userId,
              );
              return player.copyWith(totalScore: standing.totalScore);
            }).toList();

            updatedRoom = state.room!.copyWith(players: updatedPlayers);
          }

          emit(
            state.copyWith(
              roundResult: result,
              status: GameStatus.roundResult,
              room: updatedRoom,
            ),
          );

        case GameEnded(:final result):
          log('[GameBloc] Game ended! Winner: ${result.winnerUserId}');
          emit(state.copyWith(gameResult: result, status: GameStatus.finished));

        // Error Events
        case GameErrorUpdate(:final code, :final message):
          log('[GameBloc] Error received: $code - $message');
          emit(
            state.copyWith(error: Failure(int.tryParse(code) ?? 500, message)),
          );
        // Invite Events
        case InviteSent():
        case InviteReceived():
        case InviteResponse():
      }
    } catch (e, stackTrace) {
      log('[GameBloc] Update handling error: $e', stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() async {
    log('[GameBloc] Closing and cleaning up...');
    await _updateSubscription?.cancel();
    _updateSubscription = null;
    return super.close();
  }
}
