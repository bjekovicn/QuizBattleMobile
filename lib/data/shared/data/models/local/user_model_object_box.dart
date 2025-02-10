import 'package:objectbox/objectbox.dart';

@Entity()
class UserModelObjectBox {
  @Id()
  int id;

  @Unique()
  int userId;

  String? firstName;
  String? lastName;
  String? googlePhoto;
  int coins;
  int tokens;
  int gamesWon;
  int gamesLost;

  UserModelObjectBox({
    this.id = 0,
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
