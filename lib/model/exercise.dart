import 'package:simple_exercise_builder/model/enum.dart';
import 'package:simple_exercise_builder/model/generic.dart';

class Exercise implements GenericModel {
  static const EXERCISES = 'exer';
  static const MUSCLE_GROUPS = 'musc';
  static const ID = 'id';
  static const NAME = 'name';
  static const DEFAULT_REST = 'def-rest';
  int? availableExercises;
  int? muscleGroups;
  int? id;
  int? defaultRestTimeSeconds;
  String? name;

  Exercise({
    this.availableExercises,
    this.muscleGroups,
    this.id,
    this.name,
    this.defaultRestTimeSeconds,
  });

  Set<MuscleGroup> get muscleGroupsSet => muscleGroups == null
      ? throw ArgumentError('Muscle Groups Must not be null on runtime')
      : convertIntToMuscleGroups(muscleGroups!);

  Set<ExerciseEquipment> get availableExerciseEquipment =>
      availableExercises == null
          ? throw ArgumentError('ExerciseEquipment Must not be null on runtime')
          : convertIntToExerciseEquipment(availableExercises!);

  @override
  void loadFromMap(Map<String, dynamic> map) {
    availableExercises = map[EXERCISES];
    muscleGroups = map[MUSCLE_GROUPS];
    id = map[ID];
    name = map[NAME];
    defaultRestTimeSeconds = map[DEFAULT_REST];
  }

  @override
  Map<String, dynamic> toMap() => {
        EXERCISES: availableExercises,
        MUSCLE_GROUPS: muscleGroups,
        ID: id,
        NAME: name,
        DEFAULT_REST: defaultRestTimeSeconds
      };

  @override
  int get typeId => 0;
}
