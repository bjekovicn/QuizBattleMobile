import 'package:injectable/injectable.dart';

import '/data/shared/data/models/local/user_model_hive.dart';
import '/data/shared/data/data_sources/local/key_value_storage.dart';
import '/data/rankings/data/data_sources/local/rankings_storage_service.dart';

const _kUsersBoxRankingsKey = 'users_box_rankings';

@LazySingleton(as: RankingsStorageService)
class RankingsStorageServiceImpl
    implements RankingsStorageService<UserModelHive> {
  final KeyValueStorage<List<UserModelHive>> _storage;

  RankingsStorageServiceImpl(@Named('UsersListStorage') this._storage);

  @override
  Future<void> cacheRankings(List<UserModelHive> rankings) async {
    await _storage.put(_kUsersBoxRankingsKey, rankings);
  }

  @override
  Future<List<UserModelHive>?> getCachedRankings() {
    return _storage.get(_kUsersBoxRankingsKey);
  }
}
