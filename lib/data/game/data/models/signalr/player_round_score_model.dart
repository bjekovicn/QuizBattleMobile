import 'package:json_annotation/json_annotation.dart';

part 'player_round_score_model.g.dart';

@JsonSerializable()
class PlayerRoundScoreModel {
  final int userId;
  final String displayName;
  final int roundScore;
  final int totalScore;
  final bool wasCorrect;

  const PlayerRoundScoreModel({
    required this.userId,
    required this.displayName,
    required this.roundScore,
    required this.totalScore,
    required this.wasCorrect,
  });

  factory PlayerRoundScoreModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerRoundScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerRoundScoreModelToJson(this);
}
