import 'package:json_annotation/json_annotation.dart';
import 'matched_player_model.dart';

part 'match_found_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchFoundEventModel {
  final String roomId;
  final List<MatchedPlayerModel> players;

  const MatchFoundEventModel({
    required this.roomId,
    required this.players,
  });

  factory MatchFoundEventModel.fromJson(Map<String, dynamic> json) =>
      _$MatchFoundEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchFoundEventModelToJson(this);
}
