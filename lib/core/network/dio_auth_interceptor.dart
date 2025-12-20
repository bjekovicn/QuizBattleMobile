import 'dart:developer';

import 'package:dio/dio.dart';

import '/data/auth/data/models/auth_model.dart';
import '/data/auth/data/data_sources/local/auth_storage_service.dart';

class DioAuthInterceptor extends QueuedInterceptor {
  final AuthStorageService _authStorage;
  final Dio _dio;

  DioAuthInterceptor(this._authStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from storage
    final authData = await _authStorage.getAuthData();

    if (authData != null && authData.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${authData.accessToken}';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      log('[Auth] 401 Unauthorized - Attempting token refresh');

      // Try to refresh the token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the failed request with new token
        try {
          final response = await _retry(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          log('[Auth] Retry failed after token refresh: $e');
          return handler.reject(err);
        }
      } else {
        log('[Auth] Token refresh failed - User needs to login again');
        // Clear auth data and let the error propagate
        await _authStorage.clearAuthData();
        return handler.reject(err);
      }
    }

    // For other errors, just pass them through
    handler.next(err);
  }

  /// Attempts to refresh the access token using the refresh token
  Future<bool> _refreshToken() async {
    try {
      final authData = await _authStorage.getAuthData();

      if (authData == null || authData.refreshToken.isEmpty) {
        log('[Auth] No refresh token available');
        return false;
      }

      log('[Auth] Refreshing access token...');

      // Create a separate Dio instance without interceptors to avoid infinite loop
      final refreshDio = Dio(BaseOptions(
        baseUrl: _dio.options.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      // Call refresh endpoint
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': authData.refreshToken},
      );

      if (response.statusCode == 200) {
        final newAuthData = AuthModel.fromJson(response.data);
        await _authStorage.saveAuthData(newAuthData);
        log('[Auth] Token refreshed successfully');
        return true;
      }

      log('[Auth] Token refresh failed with status: ${response.statusCode}');
      return false;
    } catch (e) {
      log('[Auth] Token refresh error: $e');
      return false;
    }
  }

  /// Retries the failed request with the new access token
  Future<Response> _retry(RequestOptions requestOptions) async {
    final authData = await _authStorage.getAuthData();

    if (authData != null) {
      requestOptions.headers['Authorization'] =
          'Bearer ${authData.accessToken}';
    }

    // Create new options from the old request
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    // Retry the request
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
