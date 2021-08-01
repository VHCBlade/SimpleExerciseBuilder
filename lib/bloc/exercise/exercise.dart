import 'package:event_bloc/event_bloc.dart';
import 'package:search_me_up/search_me_up.dart';
import 'package:simple_exercise_builder/model/exercise.dart';
import 'package:simple_exercise_builder/repository/exercise_repo.dart';

class ExerciseBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;
  final ExerciseRepository repo;

  late final searchMeUp =
      SearchMeUp<Exercise>(DefaultSearchMeUpDelegate(converters: [
    (exer) => [exer.name!]
  ]));

  ExerciseBloc({BlocEventChannel? parentChannel, required this.repo})
      : eventChannel = BlocEventChannel(parentChannel);

  List<int> exerciseList = [];
  Map<int, Exercise> exerciseMap = {};
  String? searchTerm;

  /// This will load the exercises from the [repo]
  void loadExercises() async {
    final exercises = await repo.retrieveExercise();

    exercises.forEach((element) => exerciseMap[element.id!] = element);
    _generateExerciseList();
    updateBloc();
  }

  /// Generates the exercise list in the correct order. This will take into account the given [searchTerm]
  void _generateExerciseList() {
    exerciseList.clear();
    if (searchTerm == null) {
      _addExercisesSorted(exerciseMap.values);
      return;
    }

    final search = searchMeUp.rankedSearch(searchTerm!, exerciseMap.values);
    search.forEach(_addExercisesSorted);
  }

  /// Will sort the [exercises] and then add them to the [exerciseList]
  void _addExercisesSorted(Iterable<Exercise> exercises) {
    final sortedExercises = exercises.toList()
      ..sort((a, b) => a.name!.compareTo(b.name!));
    exerciseList.addAll(sortedExercises.map((val) => val.id!));
  }
}
