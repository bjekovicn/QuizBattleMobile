import 'package:json_annotation/json_annotation.dart';

part 'player_answer_model.g.dart';

@JsonSerializable()
class PlayerAnswerModel {
  final String answer;
  final int responseTimeMs;
  final int answeredAt;

  const PlayerAnswerModel({
    required this.answer,
    required this.responseTimeMs,
    required this.answeredAt,
  });

  factory PlayerAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerAnswerModelToJson(this);
}
