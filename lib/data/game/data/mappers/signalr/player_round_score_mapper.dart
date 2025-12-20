import 'package:quizcleandemo/data/game/data/models/signalr/player_round_score_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/player_round_score_entity.dart';

extension PlayerRoundScoreModelMapper on PlayerRoundScoreModel {
  PlayerRoundScoreEntity toEntity() {
    return PlayerRoundScoreEntity(
      userId: userId,
      displayName: displayName,
      roundScore: roundScore,
      totalScore: totalScore,
      wasCorrect: wasCorrect,
    );
  }
}

extension PlayerRoundScoreEntityMapper on PlayerRoundScoreEntity {
  PlayerRoundScoreModel toModel() {
    return PlayerRoundScoreModel(
      userId: userId,
      displayName: displayName,
      roundScore: roundScore,
      totalScore: totalScore,
      wasCorrect: wasCorrect,
    );
  }
}
