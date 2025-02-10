import 'package:hive/hive.dart';

part 'user_model_hive.g.dart';

@HiveType(typeId: 0)
class UserModelHive {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String? googlePhoto;

  @HiveField(4)
  final int coins;

  @HiveField(5)
  final int tokens;

  @HiveField(6)
  final int gamesWon;

  @HiveField(7)
  final int gamesLost;

  UserModelHive({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.googlePhoto,
    required this.coins,
    required this.tokens,
    required this.gamesWon,
    required this.gamesLost,
  });
}
