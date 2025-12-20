import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/data/shared/data/models/user_model.dart';

part 'user_api_service.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _UserApiService;

  @GET('/users/me')
  Future<HttpResponse<UserModel>> getCurrentUser();

  @POST('/user/{userId}/challenge')
  Future<HttpResponse<String>> challengeFriend(
    @Path("userId") int userId,
    @Body() Map<String, dynamic> body,
  );
}
