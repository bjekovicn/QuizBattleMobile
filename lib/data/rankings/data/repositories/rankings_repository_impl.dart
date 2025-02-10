import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '/core/error_handling/failure.dart';
import '/data/shared/domain/entities/user_entity.dart';
import '/data/rankings/domain/repositories/rankings_repository.dart';
import '/data/shared/data/mappers/remote/user_model_json_mapper.dart';
import '/data/rankings/data/data_sources/remote/rankings_api_service.dart';

@Named("RankingsRepository")
@LazySingleton(as: RankingsRepository)
class RankingsRepositoryImpl implements RankingsRepository {
  final RankingsApiService _rankingsApiService;

  RankingsRepositoryImpl(this._rankingsApiService);

  @override
  Future<Either<Failure, List<UserEntity>>> getAllTimeRankedUsers() async {
    try {
      final res = await _rankingsApiService.getAllTimeRankedUsers();

      final userEntities = res.data.map((user) {
        return user.mapToEntity();
      }).toList();
      return Right(userEntities);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getMonthlyRankedUsers() async {
    try {
      final res = await _rankingsApiService.getMonthlyRankedUsers();

      final userEntities = res.data.map((user) {
        return user.mapToEntity();
      }).toList();
      return Right(userEntities);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getWeeklyRankedUsers() async {
    try {
      final res = await _rankingsApiService.getWeeklyRankedUsers();

      final userEntities = res.data.map((user) {
        return user.mapToEntity();
      }).toList();
      return Right(userEntities);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }
}
