import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '/core/error_handling/failure.dart';
import '/data/shared/domain/entities/user_entity.dart';
import '/data/shared/data/models/local/user_model_hive.dart';
import '/data/user/domain/repositories/users_repository.dart';
import '/data/shared/data/mappers/local/user_model_hive_mapper.dart';
import '/data/user/data/data_sources/local/users_storage_service.dart';

@Named("CachedUsersRepository")
@LazySingleton(as: UsersRepository)
class CachedUsersRepositoryImpl implements UsersRepository {
  final UsersRepository _repository;
  final UsersStorageService<UserModelHive> _storage;

  CachedUsersRepositoryImpl(
    @Named("UsersRepository") this._repository,
    this._storage,
  );

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final apiResult = await _repository.getCurrentUser();
    return apiResult.fold(
      (Failure failure) async {
        final cachedUser = await _storage.getCachedCurrentUser();
        if (cachedUser == null) return Left(failure);

        return Right(cachedUser.mapToEntity());
      },
      (UserEntity userEntity) async {
        await _storage.cacheCurrentUser(
          userEntity.mapToModel(),
        );
        return Right(userEntity);
      },
    );
  }

  @override
  Future<Either<Failure, void>> challengeUser(int userId, String roomId) {
    return _repository.challengeUser(userId, roomId);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFriends() async {
    final apiResult = await _repository.getFriends();
    return apiResult.fold(
      (Failure failure) async {
        final cachedRankings = await _storage.getCachedFriends();
        if (cachedRankings == null) return Left(failure);

        final userEntityList = cachedRankings.map((userModel) {
          return userModel.mapToEntity();
        }).toList();
        return Right(userEntityList);
      },
      (List<UserEntity> data) async {
        final userModelsList = data.map((userEntity) {
          return userEntity.mapToModel();
        }).toList();
        await _storage.cacheFriends(userModelsList);
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addFriend(int receiverId) {
    return _repository.addFriend(receiverId);
  }

  @override
  Future<Either<Failure, void>> removeFriend(int receiverId) {
    return _repository.removeFriend(receiverId);
  }
}
