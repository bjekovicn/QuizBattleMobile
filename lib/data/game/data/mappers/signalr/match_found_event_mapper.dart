import 'package:quizcleandemo/data/game/data/models/signalr/match_found_event_model.dart';
import 'package:quizcleandemo/data/game/domain/entities/game/match_found_event_entity.dart';

import 'matched_player_mapper.dart';

extension MatchFoundEventModelMapper on MatchFoundEventModel {
  MatchFoundEventEntity toEntity() {
    return MatchFoundEventEntity(
      roomId: roomId,
      players: players.map((p) => p.toEntity()).toList(),
    );
  }
}

extension MatchFoundEventEntityMapper on MatchFoundEventEntity {
  MatchFoundEventModel toModel() {
    return MatchFoundEventModel(
      roomId: roomId,
      players: players.map((p) => p.toModel()).toList(),
    );
  }
}
