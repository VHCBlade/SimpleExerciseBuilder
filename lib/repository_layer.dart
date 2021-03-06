import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/repository/exercise/exercise_repo.dart';

class RepositoryLayer extends StatelessWidget {
  final Widget child;

  const RepositoryLayer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ExerciseRepository>(
        create: (context) => DevExerciseRepository(), child: child);
  }
}
