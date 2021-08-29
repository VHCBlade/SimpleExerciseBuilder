import 'package:event_bloc/event_bloc.dart';
import 'package:search_me_up/search_me_up.dart';
import 'package:simple_exercise_builder/model/exercise.dart';
import 'package:simple_exercise_builder/repository/exercise_repo.dart';

class ExerciseBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;
  final ExerciseRepository repo;

  late final _searchMeUp =
      SearchMeUp<Exercise>(DefaultSearchMeUpDelegate(converters: [
    (exer) => [exer.name!]
  ]));

  ExerciseBloc({BlocEventChannel? parentChannel, required this.repo})
      : eventChannel = BlocEventChannel(parentChannel);

  final exerciseList = <int>[];
  final exerciseMap = <int, Exercise>{};
  Exercise? selectedExercise;
  String? searchTerm;

  void selectExercise(Exercise? exercise) {
    updateBlocOnChange(
        change: () => selectedExercise = exercise,
        tracker: () => [selectedExercise]);
  }

  /// This will load the exercises from the [repo]
  void loadExercises() async {
    final exercises = await repo.retrieveExercises();

    exercises.forEach((element) => exerciseMap[element.id!] = element);
    _generateExerciseList();
    updateBloc();
  }

  void search(String search) {
    final actualSearch = search.trim().isEmpty ? null : search.trim();
    if (actualSearch == searchTerm) {
      return;
    }

    searchTerm = actualSearch;
    _generateExerciseList();
    updateBloc();
  }

  /// Generates the exercise list in the correct order. This will take into account the given [searchTerm]
  void _generateExerciseList() {
    exerciseList.clear();
    if (searchTerm == null) {
      _sortExercisesThenAdd(exerciseMap.values);
      return;
    }

    final search = _searchMeUp.rankedSearch(searchTerm!, exerciseMap.values);
    search.forEach(_sortExercisesThenAdd);
  }

  /// Will sort the [exercises] and then add them to the [exerciseList]
  void _sortExercisesThenAdd(Iterable<Exercise> exercises) {
    final sortedExercises = exercises.toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));
    exerciseList.addAll(sortedExercises.map((val) => val.id!));
  }
}
