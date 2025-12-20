import 'package:fpdart/fpdart.dart';

import '/core/error_handling/failure.dart';
import '/data/game/domain/updates/game_update.dart';
import '/data/game/domain/entities/game/game_room_entity.dart';

abstract class GameRepository {
  // Connection
  Future<Either<Failure, void>> connect(String token);
  Future<Either<Failure, void>> disconnect();

  // Stream of all game updates
  Stream<GameUpdate> get updates;

  // Matchmaking
  Future<Either<Failure, void>> joinMatchmaking(
    int gameType,
    String languageCode,
  );
  Future<Either<Failure, void>> leaveMatchmaking(
    int gameType,
    String languageCode,
  );

  // Room operations
  Future<Either<Failure, GameRoomEntity?>> createRoom(
    int gameType,
    String languageCode,
    int rounds,
  );
  Future<Either<Failure, void>> leaveRoom(String roomId);
  Future<Either<Failure, void>> setReady(String roomId, bool ready);

  // Game operations
  Future<Either<Failure, void>> submitAnswer(String roomId, String answer);
}
