import 'package:json_annotation/json_annotation.dart';

part 'player_round_result_model.g.dart';

@JsonSerializable()
class PlayerRoundResultModel {
  final int userId;
  final String displayName;
  final String? answerGiven;
  final int? responseTimeMs;
  final int pointsAwarded;
  final bool isCorrect;

  const PlayerRoundResultModel({
    required this.userId,
    required this.displayName,
    this.answerGiven,
    this.responseTimeMs,
    required this.pointsAwarded,
    required this.isCorrect,
  });

  factory PlayerRoundResultModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerRoundResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerRoundResultModelToJson(this);
}
