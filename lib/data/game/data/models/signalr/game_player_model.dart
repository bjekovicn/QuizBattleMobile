import 'package:json_annotation/json_annotation.dart';
import 'player_answer_model.dart';

part 'game_player_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GamePlayerModel {
  final int userId;
  final String displayName;
  final String? photoUrl;
  final String colorHex;
  final String colorName;
  final int totalScore;
  final int currentRoundScore;
  final bool isReady;
  final bool isConnected;
  final PlayerAnswerModel? currentAnswer;
  final int joinedAt;

  const GamePlayerModel({
    required this.userId,
    required this.displayName,
    this.photoUrl,
    required this.colorHex,
    required this.colorName,
    required this.totalScore,
    required this.currentRoundScore,
    required this.isReady,
    required this.isConnected,
    this.currentAnswer,
    required this.joinedAt,
  });

  factory GamePlayerModel.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$GamePlayerModelToJson(this);
}
