import 'package:json_annotation/json_annotation.dart';

part 'matchmaking_update_event_model.g.dart';

@JsonSerializable()
class MatchmakingUpdateEventModel {
  final int queuePosition;
  final int playersInQueue;

  const MatchmakingUpdateEventModel({
    required this.queuePosition,
    required this.playersInQueue,
  });

  factory MatchmakingUpdateEventModel.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingUpdateEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchmakingUpdateEventModelToJson(this);
}
