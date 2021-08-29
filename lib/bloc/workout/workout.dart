import 'package:event_bloc/event_bloc.dart';
import 'package:search_me_up/search_me_up.dart';
import 'package:simple_exercise_builder/model/workout.dart';
import 'package:simple_exercise_builder/repository/workout_repo.dart';

class WorkoutBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;
  final WorkoutRepository repo;

  late final _searchMeUp = SearchMeUp<Workout>(
    DefaultSearchMeUpDelegate(
      converters: [
        (workout) => [workout.name!]
      ],
    ),
  );

  WorkoutBloc({BlocEventChannel? parentChannel, required this.repo})
      : eventChannel = BlocEventChannel(parentChannel);

  final workoutList = <int>[];
  final workoutMap = <int, Workout>{};
  String? searchTerm;

  /// This will load the workouts from the [repo]
  void loadWorkouts() async {
    final workouts = await repo.retrieveWorkouts();
    workoutMap.clear();
    workouts.forEach((element) => workoutMap[element.id!] = element);
    _generateWorkoutList();
    updateBloc();
  }

  void search(String search) {
    final actualSearch = search.trim().isEmpty ? null : search.trim();
    if (actualSearch == searchTerm) {
      return;
    }

    searchTerm = actualSearch;
    _generateWorkoutList();
    updateBloc();
  }

  void addNewWorkout() async {
    await repo.addWorkout(
      Workout(
        id: null,
        name: 'New Workout',
        userMade: true,
      ),
    );

    // TODO: optimize to add to workoutMap directly
    loadWorkouts();
  }

  void deleteWorkout(Workout workout) async {
    await repo.deleteWorkout(workout);

    // TODO: optimize to delete from workoutMap directly
    loadWorkouts();
  }

  void duplicateWorkout(Workout workout) async {
    final clone = Workout();
    clone.loadFromMap(workout.toMap());
    clone.id = null;
    clone.name = 'Copy of ${clone.name}';
    await repo.addWorkout(clone);

    // TODO: optimize to add to workoutMap directly
    loadWorkouts();
  }

  /// Runs [_generatePreCreatedWorkoutList] and [_generateUserCreatedWorkoutList].
  /// Repopulates the workout lists ([preCreatedWorkoutList] and [userCreatedWorkoutList]) using [workoutMap] as reference.
  /// This will take into account the given [searchTerm].
  void _generateWorkoutList() {
    workoutList.clear();
    if (searchTerm == null) {
      _sortWorkoutsThenAdd(workoutMap.values);
      return;
    }

    final search = _searchMeUp.rankedSearch(searchTerm!, workoutMap.values);
    search.forEach(_sortWorkoutsThenAdd);
  }

  /// Sort the [workouts] and then add them to the [workoutList]
  void _sortWorkoutsThenAdd(Iterable<Workout> workouts) {
    final sortedWorkouts = workouts.toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));
    workoutList.addAll(sortedWorkouts.map((val) => val.id!));
  }
}
