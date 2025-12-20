import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/data/auth/data/models/auth_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthApiService;

  @POST('/auth/google')
  Future<HttpResponse<AuthModel>> authGoogle(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/refresh')
  Future<HttpResponse<AuthModel>> refresh(
    @Body() Map<String, String> body,
  );
}
