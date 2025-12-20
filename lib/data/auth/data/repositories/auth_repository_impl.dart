import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '/core/error_handling/failure.dart';
import '/data/auth/data/mappers/auth_mappers.dart';
import '/data/auth/domain/entities/auth_entity.dart';
import '/data/auth/domain/repositories/auth_repository.dart';
import '/data/auth/data/data_sources/remote/auth_api_service.dart';
import '/data/auth/data/data_sources/local/auth_storage_service.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  final AuthStorageService _authStorageService;

  AuthRepositoryImpl(
    this._authApiService,
    this._authStorageService,
  );

  @override
  Future<Either<Failure, AuthEntity>> authGoogle(String googleToken) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();

      int? devicePlatform;
      if (Platform.isAndroid) {
        devicePlatform = 1;
      } else if (Platform.isIOS) {
        devicePlatform = 2;
      }

      final platform = Platform.operatingSystem;
      final version = Platform.operatingSystemVersion;

      final requestBody = {
        'idToken': googleToken,
        'deviceToken': token,
        'devicePlatform': devicePlatform,
        'deviceInfo': '$platform $version',
      };

      final res = await _authApiService.authGoogle(requestBody);

      await _authStorageService.saveAuthData(res.data);

      return Right(res.data.mapToEntity());
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, void>> clearStoredAuthData() async {
    try {
      await _authStorageService.clearAuthData();
      return Right(null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getStoredAuthData() async {
    try {
      final authModel = await _authStorageService.getAuthData();
      if (authModel == null) return Right(null);

      return Right(authModel.mapToEntity());
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, void>> storeAuthData(AuthEntity value) async {
    try {
      await _authStorageService.saveAuthData(value.mapToModel());
      return Right(null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<int?> getUserIdFromToken() async {
    try {
      final storedData = await _authStorageService.getAuthData();
      if (storedData == null) return null;

      final parts = storedData.accessToken.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final payloadMap = json.decode(
        utf8.decode(base64Url.decode(normalizedPayload)),
      ) as Map<String, dynamic>;

      final userIdString = payloadMap['sub'] as String?;
      if (userIdString == null) return null;

      return int.tryParse(userIdString);
    } catch (e) {
      return null;
    }
  }
}
