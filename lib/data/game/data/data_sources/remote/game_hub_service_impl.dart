import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'game_hub_service.dart';
import '/core/error_handling/failure.dart';
import '/core/di/app_config_module.dart';
import '/core/utils/signalr_helper.dart';

@LazySingleton(as: GameHubService)
class GameHubServiceImpl implements GameHubService {
  final AppConfig _config;
  HubConnection? _connection;
  final Map<String, dynamic> _pendingHandlers = {};

  GameHubServiceImpl(this._config);

  @override
  Future<Either<Failure, void>> connect(String token) async {
    try {
      log('[SignalR] Building connection...');

      _connection = HubConnectionBuilder()
          .withUrl(
            _config.signalRHubUrl,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token,
              transport: HttpTransportType.WebSockets,
              skipNegotiation: true,
            ),
          )
          .withAutomaticReconnect()
          .build();

      // KRITIČNO: Registruj sve pending handlere PRIJE start()
      log('[SignalR] Registering ${_pendingHandlers.length} pending event handlers...');
      _pendingHandlers.forEach((eventName, handler) {
        handler(); // Pozovi svaku registrovanu funkciju
      });
      log('[SignalR] All pending handlers registered');

      log('[SignalR] Starting connection...');
      await _connection!.start();
      log('[SignalR] Connected successfully');

      return const Right(null);
    } catch (e, stackTrace) {
      log('[SignalR] Connection failed: $e', stackTrace: stackTrace);
      return Left(Failure.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      log('[SignalR] Disconnecting...');
      await _connection?.stop();
      _connection = null;
      _pendingHandlers.clear();
      return const Right(null);
    } catch (e) {
      return Left(Failure.handle(e));
    }
  }

  @override
  void on<TModel>(
    String event,
    TModel Function(Map<String, dynamic>) fromJson,
    void Function(TModel) callback,
  ) {
    // Ako connection postoji, registruj odmah
    if (_connection != null) {
      log('[SignalR] Registering handler for: $event (immediate)');
      SignalRHelper.onJsonEvent(
        _connection,
        event,
        fromJson,
        callback,
      );
    } else {
      // Ako connection ne postoji, dodaj u pending
      log('[SignalR] Queueing handler for: $event (pending)');
      _pendingHandlers[event] = () {
        SignalRHelper.onJsonEvent(
          _connection,
          event,
          fromJson,
          callback,
        );
      };
    }
  }

  @override
  void onArgs<T1, T2>(
    String eventName,
    void Function(T1, T2) callback,
  ) {
    // Ako connection postoji, registruj odmah
    if (_connection != null) {
      log('[SignalR] Registering handler for: $eventName (immediate)');
      SignalRHelper.onTwoArgEvent<T1, T2>(
        _connection,
        eventName,
        callback,
      );
    } else {
      // Ako connection ne postoji, dodaj u pending
      log('[SignalR] Queueing handler for: $eventName (pending)');
      _pendingHandlers[eventName] = () {
        SignalRHelper.onTwoArgEvent<T1, T2>(
          _connection,
          eventName,
          callback,
        );
      };
    }
  }

  @override
  Future<Either<Failure, T?>> invoke<T>(
    String method, {
    List<Object?>? args,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      if (_connection == null) {
        return Left(Failure(500, 'SignalR connection not established'));
      }

      final result = await _connection!.invoke(
        method,
        args: args?.whereType<Object>().toList(),
      );

      if (result == null) return const Right(null);
      if (fromJson == null) return const Right(null);

      return Right(fromJson(result as Map<String, dynamic>));
    } catch (e, stackTrace) {
      log('[SignalR] Invoke failed: $method', error: e, stackTrace: stackTrace);
      return Left(Failure.handle(e));
    }
  }
}
