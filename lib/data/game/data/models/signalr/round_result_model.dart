import 'package:json_annotation/json_annotation.dart';
import 'player_round_result_model.dart';
import 'player_score_model.dart';

part 'round_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoundResultModel {
  final int roundNumber;
  final int questionId;
  final String correctOption;
  final String correctAnswerText;
  final List<PlayerRoundResultModel> playerResults;
  final List<PlayerScoreModel> currentStandings;

  const RoundResultModel({
    required this.roundNumber,
    required this.questionId,
    required this.correctOption,
    required this.correctAnswerText,
    required this.playerResults,
    required this.currentStandings,
  });

  factory RoundResultModel.fromJson(Map<String, dynamic> json) =>
      _$RoundResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoundResultModelToJson(this);
}
