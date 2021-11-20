import 'package:event_bloc/event_bloc.dart';
import 'package:simple_exercise_builder/model/exercise.dart';

abstract class ExerciseRepository extends Repository {
  Future<Iterable<Exercise>> retrieveExercises();
}
