import 'package:quizcleandemo/data/game/domain/entities/game/matched_player_entity.dart';

class MatchFoundEventEntity {
  final String roomId;
  final List<MatchedPlayerEntity> players;

  const MatchFoundEventEntity({
    required this.roomId,
    required this.players,
  });

  MatchFoundEventEntity copyWith({
    String? roomId,
    List<MatchedPlayerEntity>? players,
  }) {
    return MatchFoundEventEntity(
      roomId: roomId ?? this.roomId,
      players: players ?? this.players,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchFoundEventEntity &&
          runtimeType == other.runtimeType &&
          roomId == other.roomId;

  @override
  int get hashCode => roomId.hashCode;
}
