import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/data/game/data/models/rest/respond_to_invite_response.dart';

part 'game_invite_api_service.g.dart';

@RestApi()
abstract class GameInviteApiService {
  factory GameInviteApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _GameInviteApiService;

  @POST('/game/invites/{inviteId}/respond')
  Future<HttpResponse<RespondToInviteResponse>> respondToInvite(
    @Path('inviteId') String inviteId,
    @Body() Map<String, dynamic> body,
  );
}
