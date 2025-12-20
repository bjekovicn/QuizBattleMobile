import 'package:quizcleandemo/data/game/data/mappers/signalr/game_player_mapper.dart';
import 'package:quizcleandemo/data/game/data/mappers/signalr/game_question_mapper.dart';
import 'package:quizcleandemo/data/game/data/models/signalr/game_room_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_room_entity.dart';

extension GameRoomModelMapper on GameRoomModel {
  GameRoomEntity toEntity() {
    return GameRoomEntity(
      id: id,
      gameType: gameType,
      status: status,
      languageCode: languageCode,
      totalRounds: totalRounds,
      currentRound: currentRound,
      hostPlayerId: hostPlayerId,
      createdAt: createdAt,
      startedAt: startedAt,
      roundStartedAt: roundStartedAt,
      roundEndsAt: roundEndsAt,
      players: players.map((p) => p.toEntity()).toList(),
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}

extension GameRoomEntityMapper on GameRoomEntity {
  GameRoomModel toModel() {
    return GameRoomModel(
      id: id,
      gameType: gameType,
      status: status,
      languageCode: languageCode,
      totalRounds: totalRounds,
      currentRound: currentRound,
      hostPlayerId: hostPlayerId,
      createdAt: createdAt,
      startedAt: startedAt,
      roundStartedAt: roundStartedAt,
      roundEndsAt: roundEndsAt,
      players: players.map((p) => p.toModel()).toList(),
      questions: questions.map((q) => q.toModel()).toList(),
    );
  }
}
