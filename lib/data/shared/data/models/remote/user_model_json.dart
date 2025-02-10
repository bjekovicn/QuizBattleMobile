import 'package:json_annotation/json_annotation.dart';

part 'user_model_json.g.dart';

@JsonSerializable()
class UserModelJson {
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? googlePhoto;
  final int coins;
  final int tokens;
  final int gamesWon;
  final int gamesLost;

  UserModelJson({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.googlePhoto,
    required this.coins,
    required this.tokens,
    required this.gamesWon,
    required this.gamesLost,
  });

  factory UserModelJson.fromJson(Map<String, dynamic> json) =>
      _$UserModelJsonFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelJsonToJson(this);
}
