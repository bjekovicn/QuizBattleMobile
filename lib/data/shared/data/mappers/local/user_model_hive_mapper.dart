import '/data/shared/domain/entities/user_entity.dart';
import '/data/shared/data/models/local/user_model_hive.dart';

extension ToEntityMapper on UserModelHive {
  UserEntity mapToEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      googlePhoto: googlePhoto,
      coins: coins,
      tokens: tokens,
      gamesWon: gamesWon,
      gamesLost: gamesLost,
    );
  }
}

extension ToModelMapper on UserEntity {
  UserModelHive mapToModel() {
    return UserModelHive(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      googlePhoto: googlePhoto,
      coins: coins,
      tokens: tokens,
      gamesWon: gamesWon,
      gamesLost: gamesLost,
    );
  }
}
