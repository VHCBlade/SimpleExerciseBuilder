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
  final _workouts = <Workout>[];
  int _index = 0;

  @override
  Future<void> addWorkout(Workout w) async {
    w.id = _index++;
    _workouts.add(w);
  }

  @override
  Future<void> deleteWorkout(Workout w) async {
    _workouts.remove(w);
  }

  @override
  Future<Iterable<Workout>> retrieveWorkouts() async {
    if (_workouts.isEmpty) {
      _generateTestWorkout();
    }

    return _workouts;
  }

  @override
  Future<Workout> retrieveWorkout(int id) async {
    return _workouts.firstWhere((element) => element.id == id);
  }

  @override
  Future<void> updateWorkout(Workout w) async {
    final index = _workouts.indexWhere((element) => element.id == w.id);
    _workouts[index] = w;
  }

  void _generateTestWorkout() {
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
      name: 'User Workout 1',
      userMade: true,
    );

    final workoutE = Workout(
      name: 'User Workout 2',
      userMade: true,
    );

    _workouts.add(workoutA);
    _workouts.add(workoutB);
    _workouts.add(workoutC);

    addWorkout(workoutD);
    addWorkout(workoutE);
  }
}
