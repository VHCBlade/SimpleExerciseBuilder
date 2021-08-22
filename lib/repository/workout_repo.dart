import 'package:event_bloc/event_bloc.dart';
import 'package:simple_exercise_builder/model/workout.dart';

abstract class WorkoutRepository extends Repository {
  Future<Iterable<Workout>> retrievePreCreatedWorkouts();
  Future<Iterable<Workout>> retrieveUserCreatedWorkouts();
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
  Future<Iterable<Workout>> retrievePreCreatedWorkouts() async {
    var incrementer = 0;
    // TODO
    return [];
  }

  @override
  Future<Iterable<Workout>> retrieveUserCreatedWorkouts() async {
    var incrementer = 0;
    // TODO
    return [];
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
