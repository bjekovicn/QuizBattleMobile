import 'package:quizcleandemo/data/game/data/models/signalr/round_result_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/round_result_entity.dart';
import 'player_round_result_mapper.dart';
import 'player_score_mapper.dart';

extension RoundResultModelMapper on RoundResultModel {
  RoundResultEntity toEntity() {
    return RoundResultEntity(
      roundNumber: roundNumber,
      questionId: questionId,
      correctOption: correctOption,
      correctAnswerText: correctAnswerText,
      playerResults: playerResults.map((p) => p.toEntity()).toList(),
      currentStandings: currentStandings.map((s) => s.toEntity()).toList(),
    );
  }
}

extension RoundResultEntityMapper on RoundResultEntity {
  RoundResultModel toModel() {
    return RoundResultModel(
      roundNumber: roundNumber,
      questionId: questionId,
      correctOption: correctOption,
      correctAnswerText: correctAnswerText,
      playerResults: playerResults.map((p) => p.toModel()).toList(),
      currentStandings: currentStandings.map((s) => s.toModel()).toList(),
    );
  }
}
