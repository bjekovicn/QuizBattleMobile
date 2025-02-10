import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '/data/shared/data/models/remote/user_model_json.dart';

part 'user_api_service.g.dart';

@RestApi()
@lazySingleton
abstract class UserApiService {
  @factoryMethod
  factory UserApiService(Dio dio) = _UserApiService;

  @GET('/user/me')
  Future<HttpResponse<UserModelJson>> getCurrentUser();

  @POST('/user/{userId}/challenge')
  Future<HttpResponse<String>> challengeFriend(
    @Path("userId") int userId,
    @Body() Map<String, dynamic> body,
  );

  //

  @GET('/friendships/accepted')
  Future<HttpResponse<List<UserModelJson>>> getFriends();

  @POST('/friendships/{id}/add')
  Future<HttpResponse<void>> addFriend(@Path("id") int receiverId);

  @DELETE('/friendships/{id}/remove')
  Future<HttpResponse<void>> removeFriend(@Path("id") int receiverId);
}
