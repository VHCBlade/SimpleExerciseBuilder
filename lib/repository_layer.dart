import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_exercise_builder/repository/exercise/dev_repo.dart';
import 'package:simple_exercise_builder/repository/exercise/exercise_repo.dart';
import 'package:simple_exercise_builder/repository/settings/settings_repo.dart';
import 'package:simple_exercise_builder/repository/settings/shared_preferences.dart';

class RepositoryLayer extends StatelessWidget {
  final Widget child;

  const RepositoryLayer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ExerciseRepository>(
        create: (context) => DevExerciseRepository(),
        child: RepositoryProvider<SettingsRepository>(
            create: (_) => SharedPreferencesRepository(), child: child));
  }
}
