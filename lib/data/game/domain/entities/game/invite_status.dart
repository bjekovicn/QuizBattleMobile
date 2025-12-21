enum InviteStatus {
  pending(0),
  accepted(1),
  rejected(2),
  expired(3),
  cancelled(4);

  final int value;
  const InviteStatus(this.value);

  static InviteStatus fromValue(int value) {
    return InviteStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => InviteStatus.pending,
    );
  }
}
