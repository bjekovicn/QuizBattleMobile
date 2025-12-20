import 'package:quizcleandemo/data/game/data/models/signalr/player_score_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/player_score_entity.dart';

extension PlayerScoreModelMapper on PlayerScoreModel {
  PlayerScoreEntity toEntity() {
    return PlayerScoreEntity(
      userId: userId,
      displayName: displayName,
      totalScore: totalScore,
    );
  }
}

extension PlayerScoreEntityMapper on PlayerScoreEntity {
  PlayerScoreModel toModel() {
    return PlayerScoreModel(
      userId: userId,
      displayName: displayName,
      totalScore: totalScore,
    );
  }
}
