class InviteResponseEventEntity {
  final int friendId;
  final String friendName;
  final String? friendPhotoUrl;
  final bool accepted;
  final String roomId;

  const InviteResponseEventEntity({
    required this.friendId,
    required this.friendName,
    this.friendPhotoUrl,
    required this.accepted,
    required this.roomId,
  });
}
