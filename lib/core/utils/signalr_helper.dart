import 'dart:developer';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRHelper {
  static Map<String, dynamic>? extractJson(List<Object?>? args, int index) {
    if (args != null && args.length > index && args[index] != null) {
      try {
        return args[index] as Map<String, dynamic>;
      } catch (e) {
        log('[SignalR] Failed to extract JSON at index $index: $e');
        return null;
      }
    }
    return null;
  }

  static T? extractArg<T>(List<Object?>? args, int index) {
    if (args != null && args.length > index && args[index] != null) {
      try {
        return args[index] as T;
      } catch (e) {
        log('[SignalR] Failed to extract arg at index $index: $e');
        return null;
      }
    }
    return null;
  }

  static void onJsonEvent<T>(
    HubConnection? connection,
    String eventName,
    T Function(Map<String, dynamic>) fromJson,
    void Function(T) callback,
  ) {
    connection?.on(eventName, (args) {
      try {
        log('[SignalR] Raw event received: $eventName, args count: ${args?.length ?? 0}');
        final json = extractJson(args, 0);
        if (json != null) {
          log('[SignalR] Event parsed: $eventName');
          final model = fromJson(json);
          callback(model);
        } else {
          log('[SignalR] $eventName: Missing JSON payload, args: $args');
        }
      } catch (e, stackTrace) {
        log('[SignalR] $eventName error: $e', stackTrace: stackTrace);
      }
    });
  }

  static void onArgEvent<T>(
    HubConnection? connection,
    String eventName,
    int index,
    void Function(T) callback,
  ) {
    connection?.on(eventName, (args) {
      try {
        log('[SignalR] 📨 Raw event received: $eventName, args count: ${args?.length ?? 0}');
        final value = extractArg<T>(args, index);
        if (value != null) {
          log('[SignalR] ✅ Event parsed: $eventName');
          callback(value);
        } else {
          log('[SignalR] ⚠️ $eventName: Missing argument at index $index, args: $args');
        }
      } catch (e, stackTrace) {
        log('[SignalR] ❌ $eventName error: $e', stackTrace: stackTrace);
      }
    });
  }

  static void onTwoArgEvent<T1, T2>(
    HubConnection? connection,
    String eventName,
    void Function(T1, T2) callback,
  ) {
    connection?.on(eventName, (args) {
      try {
        log('[SignalR] 📨 Raw event received: $eventName, args count: ${args?.length ?? 0}');
        final a = extractArg<T1>(args, 0);
        final b = extractArg<T2>(args, 1);
        if (a != null && b != null) {
          log('[SignalR] ✅ Event parsed: $eventName');
          callback(a, b);
        } else {
          log('[SignalR] ⚠️ $eventName: Missing arguments, args: $args');
        }
      } catch (e, stackTrace) {
        log('[SignalR] ❌ $eventName error: $e', stackTrace: stackTrace);
      }
    });
  }
}
