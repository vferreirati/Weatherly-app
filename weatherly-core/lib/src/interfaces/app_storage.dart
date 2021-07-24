/// Generic storage interface used by the core.
abstract class AppStorage {
  /// Retrieves an integer value associated with the key.
  ///
  /// Returns null if no value were set previously
  Future<int?> getInt({required String key});

  /// Associates an integer value with a key.
  ///
  /// Returns if the operation was successfull.
  Future<bool> setInt({required String key, required int value});
}
