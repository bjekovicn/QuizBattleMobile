import 'invite_status.dart';

class GameInviteEntity {
  final String id;
  final String roomId;
  final int hostUserId;
  final String hostDisplayName;
  final String? hostPhotoUrl;
  final int invitedUserId;
  final String invitedDisplayName;
  final String? invitedPhotoUrl;
  final InviteStatus status;
  final int sentAt;
  final int? respondedAt;
  final int expiresAt;

  const GameInviteEntity({
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

  GameInviteEntity copyWith({
    String? id,
    String? roomId,
    int? hostUserId,
    String? hostDisplayName,
    String? hostPhotoUrl,
    int? invitedUserId,
    String? invitedDisplayName,
    String? invitedPhotoUrl,
    InviteStatus? status,
    int? sentAt,
    int? respondedAt,
    int? expiresAt,
  }) {
    return GameInviteEntity(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      hostUserId: hostUserId ?? this.hostUserId,
      hostDisplayName: hostDisplayName ?? this.hostDisplayName,
      hostPhotoUrl: hostPhotoUrl ?? this.hostPhotoUrl,
      invitedUserId: invitedUserId ?? this.invitedUserId,
      invitedDisplayName: invitedDisplayName ?? this.invitedDisplayName,
      invitedPhotoUrl: invitedPhotoUrl ?? this.invitedPhotoUrl,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      respondedAt: respondedAt ?? this.respondedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  bool get isExpired {
    final now = DateTime.now().millisecondsSinceEpoch;
    return now > expiresAt;
  }

  bool get isPending => status == InviteStatus.pending;
  bool get isAccepted => status == InviteStatus.accepted;
  bool get isRejected => status == InviteStatus.rejected;
}
