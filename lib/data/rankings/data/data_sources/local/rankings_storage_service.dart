abstract class RankingsStorageService<T> {
  Future<List<T>?> getCachedRankings();
  Future<void> cacheRankings(List<T> rankings);
}
