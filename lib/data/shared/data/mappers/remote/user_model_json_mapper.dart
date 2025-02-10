import '/data/shared/domain/entities/user_entity.dart';
import '/data/shared/data/models/remote/user_model_json.dart';

extension ToEntityMapper on UserModelJson {
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
  UserModelJson mapToModel() {
    return UserModelJson(
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
