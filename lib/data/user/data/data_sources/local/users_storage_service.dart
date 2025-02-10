abstract class UsersStorageService<T> {
  Future<T?> getCachedCurrentUser();
  Future<void> cacheCurrentUser(T value);

  Future<List<T>?> getCachedFriends();
  Future<void> cacheFriends(List<T> friends);
}
