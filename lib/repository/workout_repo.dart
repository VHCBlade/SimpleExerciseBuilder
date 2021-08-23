import 'package:event_bloc/event_bloc.dart';
import 'package:simple_exercise_builder/model/workout.dart';

abstract class WorkoutRepository extends Repository {
  Future<Iterable<Workout>> retrieveWorkouts();
  Future<Workout> retrieveWorkout(int id);
  Future<void> addWorkout(Workout w);
  Future<void> updateWorkout(Workout w);
  Future<void> deleteWorkout(Workout w);
}

class DevWorkoutRepository extends WorkoutRepository {
  @override
  Future<void> addWorkout(Workout w) async {
    // TODO: implement addWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(Workout w) async {
    // TODO: implement deleteWorkout
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Workout>> retrieveWorkouts() async {
    final workoutA = Workout(
      id: -1,
      name: 'Premade Workout 1',
      userMade: false,
    );

    final workoutB = Workout(
      id: -2,
      name: 'Premade Workout 2',
      userMade: false,
    );

    final workoutC = Workout(
      id: -3,
      name: 'Premade Workout 3',
      userMade: false,
    );

    final workoutD = Workout(
      id: 0,
      name: 'User Workout 1',
      userMade: true,
    );

    final workoutE = Workout(
      id: 1,
      name: 'User Workout 2',
      userMade: true,
    );

    return [workoutA, workoutB, workoutC, workoutD, workoutE];
  }

  @override
  Future<Workout> retrieveWorkout(int id) async {
    // TODO: implement retrieveWorkout
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkout(Workout w) async {
    // TODO: implement updateWorkout
    throw UnimplementedError();
  }
}
