import 'package:json_annotation/json_annotation.dart';

part 'matched_player_model.g.dart';

@JsonSerializable()
class MatchedPlayerModel {
  final int userId;
  final String displayName;
  final String? photoUrl;

  const MatchedPlayerModel({
    required this.userId,
    required this.displayName,
    this.photoUrl,
  });

  factory MatchedPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedPlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedPlayerModelToJson(this);
}
