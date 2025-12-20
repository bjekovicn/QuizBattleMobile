import 'package:json_annotation/json_annotation.dart';

part 'game_question_model.g.dart';

@JsonSerializable()
class GameQuestionModel {
  final int questionId;
  final int roundNumber;
  final String text;
  final String optionA;
  final String optionB;
  final String optionC;
  final String correctOption;

  const GameQuestionModel({
    required this.questionId,
    required this.roundNumber,
    required this.text,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.correctOption,
  });

  factory GameQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$GameQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameQuestionModelToJson(this);
}
