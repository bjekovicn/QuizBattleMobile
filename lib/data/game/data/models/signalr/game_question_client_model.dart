import 'package:json_annotation/json_annotation.dart';

part 'game_question_client_model.g.dart';

@JsonSerializable()
class GameQuestionClientModel {
  final int questionId;
  final int roundNumber;
  final String text;
  final String optionA;
  final String optionB;
  final String optionC;

  const GameQuestionClientModel({
    required this.questionId,
    required this.roundNumber,
    required this.text,
    required this.optionA,
    required this.optionB,
    required this.optionC,
  });

  factory GameQuestionClientModel.fromJson(Map<String, dynamic> json) =>
      _$GameQuestionClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameQuestionClientModelToJson(this);
}
