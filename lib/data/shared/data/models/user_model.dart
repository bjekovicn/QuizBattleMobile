import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int userId;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  @JsonKey(name: 'photo')
  final String? googlePhoto;

  @HiveField(4)
  @JsonKey(defaultValue: 0)
  final int coins;

  @HiveField(5)
  @JsonKey(defaultValue: 0)
  final int tokens;

  @HiveField(6)
  @JsonKey(defaultValue: 0)
  final int gamesWon;

  @HiveField(7)
  @JsonKey(defaultValue: 0)
  final int gamesLost;

  UserModel({
    required this.userId,
    this.firstName,
    this.lastName,
    this.googlePhoto,
    required this.coins,
    required this.tokens,
    required this.gamesWon,
    required this.gamesLost,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
