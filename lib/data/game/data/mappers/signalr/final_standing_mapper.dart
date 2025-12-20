import 'package:quizcleandemo/data/game/data/models/signalr/final_standing_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/final_standing_entity.dart';

extension FinalStandingModelMapper on FinalStandingModel {
  FinalStandingEntity toEntity() {
    return FinalStandingEntity(
      position: position,
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
      totalScore: totalScore,
      colorHex: colorHex,
    );
  }
}

extension FinalStandingEntityMapper on FinalStandingEntity {
  FinalStandingModel toModel() {
    return FinalStandingModel(
      position: position,
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
      totalScore: totalScore,
      colorHex: colorHex,
    );
  }
}
