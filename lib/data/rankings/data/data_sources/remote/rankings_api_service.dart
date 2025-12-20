import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/data/shared/data/models/user_model.dart';

part 'rankings_api_service.g.dart';

@RestApi()
abstract class RankingsApiService {
  factory RankingsApiService(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _RankingsApiService;

  @GET('/rankings/all-time')
  Future<HttpResponse<List<UserModel>>> getAllTimeRankedUsers();

  @GET('/rankings/weekly')
  Future<HttpResponse<List<UserModel>>> getWeeklyRankedUsers();

  @GET('/rankings/monthly')
  Future<HttpResponse<List<UserModel>>> getMonthlyRankedUsers();
}
