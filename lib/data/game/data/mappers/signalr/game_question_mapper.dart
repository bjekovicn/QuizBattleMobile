import 'package:quizcleandemo/data/game/data/models/signalr/game_question_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_question_entity.dart';

extension GameQuestionModelMapper on GameQuestionModel {
  GameQuestionEntity toEntity() {
    return GameQuestionEntity(
      questionId: questionId,
      roundNumber: roundNumber,
      text: text,
      optionA: optionA,
      optionB: optionB,
      optionC: optionC,
      correctOption: correctOption,
    );
  }
}

extension GameQuestionEntityMapper on GameQuestionEntity {
  GameQuestionModel toModel() {
    return GameQuestionModel(
      questionId: questionId,
      roundNumber: roundNumber,
      text: text,
      optionA: optionA,
      optionB: optionB,
      optionC: optionC,
      correctOption: correctOption,
    );
  }
}
