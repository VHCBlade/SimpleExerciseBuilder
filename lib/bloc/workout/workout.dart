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

  List<int> workoutList = [];
  Map<int, Workout> workoutMap = {};
  String? searchTerm;

  /// This will load the workouts from the [repo]
  void loadWorkouts() async {
    final workouts = await repo.retrieveWorkouts();
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

  /// Runs [_generatePreCreatedWorkoutList] and [_generateUserCreatedWorkoutList].
  /// Repopulates the workout lists ([preCreatedWorkoutList] and [userCreatedWorkoutList]) using [workoutMap] as reference.
  /// This will take into account the given [searchTerm].
  void _generateWorkoutList() {
    workoutList.clear();
    if (searchTerm == null) {
      _addWorkoutsSorted(workoutMap.values);
      return;
    }

    final search = _searchMeUp.rankedSearch(searchTerm!, workoutMap.values);
    search.forEach(_addWorkoutsSorted);
  }

  /// Will sort the [workouts] and then add them to the [workoutIDList]
  void _addWorkoutsSorted(Iterable<Workout> workouts) {
    final sortedWorkouts = workouts.toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));
    workoutList.addAll(sortedWorkouts.map((val) => val.id!));
  }
}
