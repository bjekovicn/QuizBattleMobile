import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '/data/shared/data/models/remote/user_model_json.dart';

part 'rankings_api_service.g.dart';

@RestApi()
@lazySingleton
abstract class RankingsApiService {
  @factoryMethod
  factory RankingsApiService(Dio dio) = _RankingsApiService;

  @GET('/rankings/all-time')
  Future<HttpResponse<List<UserModelJson>>> getAllTimeRankedUsers();

  @GET('/rankings/weekly')
  Future<HttpResponse<List<UserModelJson>>> getWeeklyRankedUsers();

  @GET('/rankings/monthly')
  Future<HttpResponse<List<UserModelJson>>> getMonthlyRankedUsers();
}
