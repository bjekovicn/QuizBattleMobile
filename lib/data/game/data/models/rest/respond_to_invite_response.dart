import 'package:json_annotation/json_annotation.dart';

part 'respond_to_invite_response.g.dart';

@JsonSerializable()
class RespondToInviteResponse {
  final bool success;
  final String roomId;
  final bool accepted;

  RespondToInviteResponse({
    required this.success,
    required this.roomId,
    required this.accepted,
  });

  factory RespondToInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$RespondToInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RespondToInviteResponseToJson(this);
}
