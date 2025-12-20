import 'package:quizcleandemo/data/game/data/models/signalr/player_answer_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/player_answer_entity.dart';

extension PlayerAnswerModelMapper on PlayerAnswerModel {
  PlayerAnswerEntity toEntity() {
    return PlayerAnswerEntity(
      answer: answer,
      responseTimeMs: responseTimeMs,
      answeredAt: answeredAt,
    );
  }
}

extension PlayerAnswerEntityMapper on PlayerAnswerEntity {
  PlayerAnswerModel toModel() {
    return PlayerAnswerModel(
      answer: answer,
      responseTimeMs: responseTimeMs,
      answeredAt: answeredAt,
    );
  }
}
