import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_exercise_builder/repository/settings/settings_repo.dart';

class SharedPreferencesRepository extends SettingsRepository {
  @override
  Future<T?> get<T>(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.get(key);
    if (value == null) {
      return null;
    }

    if (value is T) {
      return value as T;
    }

    throw ArgumentError("Type of $key cannot be cast to $T");
  }

  @override
  Future<void> set<T>(String key, T value) async {
    final preferences = await SharedPreferences.getInstance();
    if (value is int) {
      preferences.setInt(key, value);
    } else if (value is double) {
      preferences.setDouble(key, value);
    } else if (value is String) {
      preferences.setString(key, value);
    } else if (value is bool) {
      preferences.setBool(key, value);
    } else if (value is List<String>) {
      preferences.setStringList(key, value);
    } else {
      throw ArgumentError("$T is not an accepted variable type!");
    }
  }
}
