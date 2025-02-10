import '/data/shared/domain/entities/user_entity.dart';
import '/data/shared/data/models/local/user_model_object_box.dart';

extension ToEntityMapper on UserModelObjectBox {
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
  UserModelObjectBox mapToModel() {
    return UserModelObjectBox(
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
