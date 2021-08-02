import 'package:event_bloc/event_bloc.dart';
import 'package:simple_exercise_builder/model/exercise.dart';

abstract class ExerciseRepository extends Repository {
  Future<Iterable<Exercise>> retrieveExercises();
}

class DevExerciseRepository extends ExerciseRepository {
  @override
  Future<Iterable<Exercise>> retrieveExercises() async {
    var incrementer = 0;
    return [
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Pull up',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Balance Board',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Plank',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Jumping Jack',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'High Knee',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Stationary Bike',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Jump Rope',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Jog',
      ),
      Exercise(
        availableExercises: 0,
        muscleGroups: 0,
        id: incrementer++,
        name: 'Push up',
      ),
    ];
  }
}
