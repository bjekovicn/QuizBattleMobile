import 'package:json_annotation/json_annotation.dart';
import '/data/game/domain/entities/game/invite_response_event_entity.dart';

part 'invite_response_event_model.g.dart';

@JsonSerializable()
class InviteResponseEventModel {
  final int friendId;
  final String friendName;
  final String? friendPhotoUrl;
  final bool accepted;
  final String roomId;

  const InviteResponseEventModel({
    required this.friendId,
    required this.friendName,
    this.friendPhotoUrl,
    required this.accepted,
    required this.roomId,
  });

  factory InviteResponseEventModel.fromJson(Map<String, dynamic> json) =>
      _$InviteResponseEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$InviteResponseEventModelToJson(this);

  InviteResponseEventEntity toEntity() {
    return InviteResponseEventEntity(
      friendId: friendId,
      friendName: friendName,
      friendPhotoUrl: friendPhotoUrl,
      accepted: accepted,
      roomId: roomId,
    );
  }
}
