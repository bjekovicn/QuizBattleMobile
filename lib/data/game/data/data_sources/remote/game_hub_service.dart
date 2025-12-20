import 'package:fpdart/fpdart.dart';
import 'package:quizcleandemo/core/error_handling/failure.dart';

abstract class GameHubService {
  Future<Either<Failure, void>> connect(String token);
  Future<Either<Failure, void>> disconnect();

  void on<TModel>(
    String event,
    TModel Function(Map<String, dynamic>) fromJson,
    void Function(TModel) callback,
  );

  void onArgs<T1, T2>(
    String event,
    void Function(T1, T2) callback,
  );

  Future<Either<Failure, T?>> invoke<T>(
    String method, {
    List<Object?>? args,
    T Function(Map<String, dynamic>)? fromJson,
  });
}
