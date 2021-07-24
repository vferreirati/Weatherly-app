import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherly_core/weatherly_core.dart';

/// `AppStorage` implementation using `Shared Preferences`.
class MobileStorage implements AppStorage {
  @override
  Future<int?> getInt({required String key}) async {
    final storage = await SharedPreferences.getInstance();

    return storage.getInt(key);
  }

  @override
  Future<bool> setInt({required String key, required int value}) async {
    final storage = await SharedPreferences.getInstance();

    return storage.setInt(key, value);
  }
}
