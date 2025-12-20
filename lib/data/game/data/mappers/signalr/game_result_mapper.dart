import 'package:quizcleandemo/data/game/data/models/signalr/game_result_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_result_entity.dart';
import 'final_standing_mapper.dart';

extension GameResultModelMapper on GameResultModel {
  GameResultEntity toEntity() {
    return GameResultEntity(
      gameRoomId: gameRoomId,
      gameType: gameType,
      totalRounds: totalRounds,
      winnerUserId: winnerUserId,
      finalStandings: finalStandings.map((s) => s.toEntity()).toList(),
      startedAt: startedAt,
      endedAt: endedAt,
    );
  }
}

extension GameResultEntityMapper on GameResultEntity {
  GameResultModel toModel() {
    return GameResultModel(
      gameRoomId: gameRoomId,
      gameType: gameType,
      totalRounds: totalRounds,
      winnerUserId: winnerUserId,
      finalStandings: finalStandings.map((s) => s.toModel()).toList(),
      startedAt: startedAt,
      endedAt: endedAt,
    );
  }
}
