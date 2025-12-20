import 'package:json_annotation/json_annotation.dart';

part 'player_score_model.g.dart';

@JsonSerializable()
class PlayerScoreModel {
  final int userId;
  final String displayName;
  final int totalScore;

  const PlayerScoreModel({
    required this.userId,
    required this.displayName,
    required this.totalScore,
  });

  factory PlayerScoreModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerScoreModelToJson(this);
}
