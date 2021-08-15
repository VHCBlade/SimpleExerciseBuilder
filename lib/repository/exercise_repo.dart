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
        availableExercises: 0x1,
        muscleGroups: 0x26,
        id: incrementer++,
        name: 'Pull ups',
      ),
      Exercise(
        availableExercises: 0x42,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'Balance Board',
      ),
      Exercise(
        availableExercises: 0x42,
        muscleGroups: 0x14,
        id: incrementer++,
        name: 'Planks',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x3F,
        id: incrementer++,
        name: 'Jumping Jacks',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'High Knees',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x10,
        id: incrementer++,
        name: 'Stationary Bike',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'Jump Rope',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'Jogging',
      ),
      Exercise(
        availableExercises: 0x42,
        muscleGroups: 0x37,
        id: incrementer++,
        name: 'Push ups',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x3F,
        id: incrementer++,
        name: 'Boxing',
      ),
      Exercise(
        availableExercises: 0x7E,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'Squats',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x1C,
        id: incrementer++,
        name: 'Elliptical Machine',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x18,
        id: incrementer++,
        name: 'Tip Toes',
      ),
      Exercise(
        availableExercises: 0x40,
        muscleGroups: 0x8,
        id: incrementer++,
        name: 'Toe Touching',
      ),
      Exercise(
        availableExercises: 0x44,
        muscleGroups: 0x3F,
        id: incrementer++,
        name: 'Burpees',
      ),
    ];
  }
}
