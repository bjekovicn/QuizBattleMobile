import 'package:quizcleandemo/data/game/data/models/signalr/matchmaking_update_event_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/matchmaking_update_entity.dart';

extension MatchmakingUpdateEventModelMapper on MatchmakingUpdateEventModel {
  MatchmakingUpdateEventEntity toEntity() {
    return MatchmakingUpdateEventEntity(
      queuePosition: queuePosition,
      playersInQueue: playersInQueue,
    );
  }
}

extension MatchmakingUpdateEventEntityMapper on MatchmakingUpdateEventEntity {
  MatchmakingUpdateEventModel toModel() {
    return MatchmakingUpdateEventModel(
      queuePosition: queuePosition,
      playersInQueue: playersInQueue,
    );
  }
}
