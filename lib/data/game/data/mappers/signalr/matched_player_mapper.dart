import 'package:quizcleandemo/data/game/data/models/signalr/matched_player_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/matched_player_entity.dart';

extension MatchedPlayerModelMapper on MatchedPlayerModel {
  MatchedPlayerEntity toEntity() {
    return MatchedPlayerEntity(
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}

extension MatchedPlayerEntityMapper on MatchedPlayerEntity {
  MatchedPlayerModel toModel() {
    return MatchedPlayerModel(
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
