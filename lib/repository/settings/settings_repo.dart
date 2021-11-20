import 'package:event_bloc/event_bloc.dart';

abstract class SettingsRepository extends Repository {
  Future<T?> get<T>(String key);
  Future<void> set<T>(String key, T value);
}
