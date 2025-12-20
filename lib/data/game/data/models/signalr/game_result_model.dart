import 'package:json_annotation/json_annotation.dart';
import 'final_standing_model.dart';

part 'game_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GameResultModel {
  final String gameRoomId;
  final int gameType;
  final int totalRounds;
  final int? winnerUserId;
  final List<FinalStandingModel> finalStandings;
  final int? startedAt;
  final int endedAt;

  const GameResultModel({
    required this.gameRoomId,
    required this.gameType,
    required this.totalRounds,
    this.winnerUserId,
    required this.finalStandings,
    this.startedAt,
    required this.endedAt,
  });

  factory GameResultModel.fromJson(Map<String, dynamic> json) =>
      _$GameResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameResultModelToJson(this);
}
