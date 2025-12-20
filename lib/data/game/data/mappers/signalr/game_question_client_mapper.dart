import 'package:quizcleandemo/data/game/data/models/signalr/game_question_client_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_question_client_entity.dart';

extension GameQuestionClientModelMapper on GameQuestionClientModel {
  GameQuestionClientEntity toEntity() {
    return GameQuestionClientEntity(
      questionId: questionId,
      roundNumber: roundNumber,
      text: text,
      optionA: optionA,
      optionB: optionB,
      optionC: optionC,
    );
  }
}

extension GameQuestionClientEntityMapper on GameQuestionClientEntity {
  GameQuestionClientModel toModel() {
    return GameQuestionClientModel(
      questionId: questionId,
      roundNumber: roundNumber,
      text: text,
      optionA: optionA,
      optionB: optionB,
      optionC: optionC,
    );
  }
}
