import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '/core/error_handling/failure.dart';
import '/data/shared/domain/entities/user_entity.dart';
import '/data/user/domain/repositories/users_repository.dart';
import '/data/user/data/data_sources/remote/user_api_service.dart';
import '/data/shared/data/mappers/remote/user_model_json_mapper.dart';

@Named("UsersRepository")
@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  final UserApiService _apiService;

  UsersRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, void>> challengeUser(int userId, String roomId) async {
    try {
      await _apiService.challengeFriend(userId, {'roomId': roomId});
      return const Right(null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final res = await _apiService.getCurrentUser();
      return Right(res.data.mapToEntity());
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFriends() async {
    try {
      final res = await _apiService.getFriends();
      final userEntities = res.data.map((user) {
        return user.mapToEntity();
      }).toList();
      return Right(userEntities);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, void>> addFriend(int receiverId) async {
    try {
      await _apiService.addFriend(receiverId);
      return const Right(null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }

  @override
  Future<Either<Failure, void>> removeFriend(int receiverId) async {
    try {
      await _apiService.removeFriend(receiverId);
      return const Right(null);
    } catch (exception) {
      return Left(Failure.handle(exception));
    }
  }
}
