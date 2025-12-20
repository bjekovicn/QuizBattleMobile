import 'package:json_annotation/json_annotation.dart';
import 'matched_player_model.dart';

part 'matchmaking_operation_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchmakingOperationResultModel {
  final bool matchFound;
  final String? roomId;
  final List<MatchedPlayerModel>? players;

  const MatchmakingOperationResultModel({
    required this.matchFound,
    this.roomId,
    this.players,
  });

  factory MatchmakingOperationResultModel.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingOperationResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MatchmakingOperationResultModelToJson(this);
}
