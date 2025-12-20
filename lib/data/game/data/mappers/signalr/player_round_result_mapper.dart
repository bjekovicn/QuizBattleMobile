import 'package:quizcleandemo/data/game/data/models/signalr/player_round_result_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/player_round_result_entity.dart';

extension PlayerRoundResultModelMapper on PlayerRoundResultModel {
  PlayerRoundResultEntity toEntity() {
    return PlayerRoundResultEntity(
      userId: userId,
      displayName: displayName,
      answerGiven: answerGiven,
      responseTimeMs: responseTimeMs,
      pointsAwarded: pointsAwarded,
      isCorrect: isCorrect,
    );
  }
}

extension PlayerRoundResultEntityMapper on PlayerRoundResultEntity {
  PlayerRoundResultModel toModel() {
    return PlayerRoundResultModel(
      userId: userId,
      displayName: displayName,
      answerGiven: answerGiven,
      responseTimeMs: responseTimeMs,
      pointsAwarded: pointsAwarded,
      isCorrect: isCorrect,
    );
  }
}
