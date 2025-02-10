import 'package:injectable/injectable.dart';

import '/data/shared/data/models/local/user_model_hive.dart';
import '/data/shared/data/data_sources/local/key_value_storage.dart';
import '/data/user/data/data_sources/local/users_storage_service.dart';

const _kUsersBoxKey = 'user_box';
const _kUsersBoxFriendsKey = 'users_box_friends';

@LazySingleton(as: UsersStorageService)
class UsersStorageServiceImpl implements UsersStorageService<UserModelHive> {
  final KeyValueStorage<UserModelHive> _userStorage;
  final KeyValueStorage<List<UserModelHive>> _usersListStorage;

  UsersStorageServiceImpl(
    @Named("UsersStorage") this._userStorage,
    @Named('UsersListStorage') this._usersListStorage,
  );

  @override
  Future<void> cacheCurrentUser(UserModelHive value) async {
    await _userStorage.put(_kUsersBoxKey, value);
  }

  @override
  Future<UserModelHive?> getCachedCurrentUser() async {
    return await _userStorage.get(_kUsersBoxKey);
  }

  @override
  Future<void> cacheFriends(List<UserModelHive> friends) async {
    await _usersListStorage.put(_kUsersBoxFriendsKey, friends);
  }

  @override
  Future<List<UserModelHive>?> getCachedFriends() async {
    return await _usersListStorage.get(_kUsersBoxFriendsKey);
  }
}
