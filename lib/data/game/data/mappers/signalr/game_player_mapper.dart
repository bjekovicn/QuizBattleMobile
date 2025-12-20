import 'package:quizcleandemo/data/game/data/models/signalr/game_player_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/game_player_entity.dart';
import 'player_answer_mapper.dart';

extension GamePlayerModelMapper on GamePlayerModel {
  GamePlayerEntity toEntity() {
    return GamePlayerEntity(
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
      colorHex: colorHex,
      colorName: colorName,
      totalScore: totalScore,
      currentRoundScore: currentRoundScore,
      isReady: isReady,
      isConnected: isConnected,
      currentAnswer: currentAnswer?.toEntity(),
      joinedAt: joinedAt,
    );
  }
}

extension GamePlayerEntityMapper on GamePlayerEntity {
  GamePlayerModel toModel() {
    return GamePlayerModel(
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
      colorHex: colorHex,
      colorName: colorName,
      totalScore: totalScore,
      currentRoundScore: currentRoundScore,
      isReady: isReady,
      isConnected: isConnected,
      currentAnswer: currentAnswer?.toModel(),
      joinedAt: joinedAt,
    );
  }
}
