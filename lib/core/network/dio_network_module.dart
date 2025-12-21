import '/injection.dart';
import 'package:dio/dio.dart';
import '/core/di/app_config_module.dart';
import 'package:injectable/injectable.dart';
import '/core/network/dio_auth_interceptor.dart';
import '/core/network/dio_logging_interceptor.dart';
import '/data/auth/data/data_sources/remote/auth_api_service.dart';
import '/data/user/data/data_sources/remote/user_api_service.dart';
import '/data/auth/data/data_sources/local/auth_storage_service.dart';
import '/data/rankings/data/data_sources/remote/rankings_api_service.dart';
import '/data/game/data/data_sources/remote/rest/game_invite_api_service.dart';
import '/data/friendships/data/data_sources/remote/friendships_api_service.dart';

@module
abstract class DioNetworkModule {
  @lazySingleton
  Dio provideDio(
    AuthStorageService authStorage,
  ) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: getIt<AppConfig>().baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    dio.interceptors.add(DioLoggingInterceptors());
    dio.interceptors.add(DioAuthInterceptor(authStorage, dio));

    return dio;
  }

  @lazySingleton
  AuthApiService provideAuthService(Dio dio) {
    return AuthApiService(
      dio,
      errorLogger: null,
      baseUrl: dio.options.baseUrl,
    );
  }

  @lazySingleton
  FriendshipsApiService provideFriendshipsService(Dio dio) {
    return FriendshipsApiService(
      dio,
      errorLogger: null,
      baseUrl: dio.options.baseUrl,
    );
  }

  @lazySingleton
  RankingsApiService provideRankingsService(Dio dio) {
    return RankingsApiService(
      dio,
      errorLogger: null,
      baseUrl: dio.options.baseUrl,
    );
  }

  @lazySingleton
  UserApiService provideUserService(Dio dio) {
    return UserApiService(
      dio,
      errorLogger: null,
      baseUrl: dio.options.baseUrl,
    );
  }

  @lazySingleton
  GameInviteApiService provideGameInviteService(Dio dio) {
    return GameInviteApiService(
      dio,
      errorLogger: null,
      baseUrl: dio.options.baseUrl,
    );
  }
}
