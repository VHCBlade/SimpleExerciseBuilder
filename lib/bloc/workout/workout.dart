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

  List<int> preCreatedWorkoutList = [];
  Map<int, Workout> preCreatedWorkoutMap = {};
  List<int> userCreatedWorkoutList = [];
  Map<int, Workout> userCreatedWorkoutMap = {};
  String? searchTerm;

  /// This will load the workouts from the [repo]
  void loadWorkouts() async {
    final preCreatedWorkouts = await repo.retrievePreCreatedWorkouts();
    preCreatedWorkouts
        .forEach((element) => preCreatedWorkoutMap[element.id!] = element);

    final userCreatedWorkouts = await repo.retrieveUserCreatedWorkouts();
    userCreatedWorkouts
        .forEach((element) => userCreatedWorkoutMap[element.id!] = element);

    _generateWorkoutLists();
    updateBloc();
  }

  void search(String search) {
    final actualSearch = search.trim().isEmpty ? null : search.trim();
    if (actualSearch == searchTerm) {
      return;
    }

    searchTerm = actualSearch;
    _generateWorkoutLists();
    updateBloc();
  }

  /// Runs [_generatePreCreatedWorkoutList] and [_generateUserCreatedWorkoutList].
  /// Repopulates the workout lists ([preCreatedWorkoutList] and [userCreatedWorkoutList]) using their respective maps ([preCreatedWorkoutMap] and [userCreatedWorkoutMap]) as reference.
  /// This will take into account the given [searchTerm].
  void _generateWorkoutLists() {
    _generatePreCreatedWorkoutList();
    _generateUserCreatedWorkoutList();
  }

  /// Runs [_generateWorkoutList] using [preCreatedWorkoutList] and [preCreatedWorkoutMap].
  /// Repopulates [preCreatedWorkoutList] in the correct order using [preCreatedWorkoutMap] as a reference.
  /// This will take into account the given [searchTerm].
  void _generatePreCreatedWorkoutList() =>
      _generateWorkoutList(preCreatedWorkoutList, preCreatedWorkoutMap);

  /// Runs [_generateWorkoutList] using [userCreatedWorkoutList] and [userCreatedWorkoutMap].
  /// Repopulates [userCreatedWorkoutList] in the correct order using [userCreatedWorkoutMap] as a reference.
  /// This will take into account the given [searchTerm].
  void _generateUserCreatedWorkoutList() =>
      _generateWorkoutList(userCreatedWorkoutList, userCreatedWorkoutMap);

  /// Repopulates [workoutList] in the correct order using [workoutMap] as a reference.
  /// This will take into account the given [searchTerm]
  void _generateWorkoutList(
    List<int> workoutList,
    Map<int, Workout> workoutMap,
  ) {
    workoutList.clear();
    if (searchTerm == null) {
      _addWorkoutsSorted(workoutMap.values, workoutList);
      return;
    }

    final search = _searchMeUp.rankedSearch(searchTerm!, workoutMap.values);
    search.forEach((workouts) => _addWorkoutsSorted(workouts, workoutList));
  }

  /// Will sort the [workouts] and then add them to the [workoutIDList]
  void _addWorkoutsSorted(
    Iterable<Workout> workouts,
    List<int> workoutIDList,
  ) {
    final sortedWorkouts = workouts.toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));
    workoutIDList.addAll(sortedWorkouts.map((val) => val.id!));
  }
}
