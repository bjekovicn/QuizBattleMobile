import 'package:json_annotation/json_annotation.dart';
import '/data/game/domain/entities/game/invite_status.dart';
import '/data/game/domain/entities/game/game_invite_entity.dart';

part 'game_invite_model.g.dart';

@JsonSerializable()
class GameInviteModel {
  final String id;
  final String roomId;
  final int hostUserId;
  final String hostDisplayName;
  final String? hostPhotoUrl;
  final int invitedUserId;
  final String invitedDisplayName;
  final String? invitedPhotoUrl;
  final int status;
  final int sentAt;
  final int? respondedAt;
  final int expiresAt;

  const GameInviteModel({
    required this.id,
    required this.roomId,
    required this.hostUserId,
    required this.hostDisplayName,
    this.hostPhotoUrl,
    required this.invitedUserId,
    required this.invitedDisplayName,
    this.invitedPhotoUrl,
    required this.status,
    required this.sentAt,
    this.respondedAt,
    required this.expiresAt,
  });

  factory GameInviteModel.fromJson(Map<String, dynamic> json) =>
      _$GameInviteModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameInviteModelToJson(this);

  GameInviteEntity toEntity() {
    return GameInviteEntity(
      id: id,
      roomId: roomId,
      hostUserId: hostUserId,
      hostDisplayName: hostDisplayName,
      hostPhotoUrl: hostPhotoUrl,
      invitedUserId: invitedUserId,
      invitedDisplayName: invitedDisplayName,
      invitedPhotoUrl: invitedPhotoUrl,
      status: InviteStatus.fromValue(status),
      sentAt: sentAt,
      respondedAt: respondedAt,
      expiresAt: expiresAt,
    );
  }
}
