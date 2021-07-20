import 'package:simple_exercise_builder/model/generic.dart';

class Exercise implements GenericModel {
  static const EXERCISES = 'exer';
  static const MUSCLE_GROUPS = 'musc';
  static const ID = 'id';
  static const NAME = 'name';
  int? availableExercises;
  int? muscleGroups;
  int? id;
  String? name;

  Exercise({
    this.availableExercises,
    this.muscleGroups,
    this.id,
    this.name,
  });

  @override
  void loadFromMap(Map<String, dynamic> map) {
    availableExercises = map[EXERCISES];
    muscleGroups = map[MUSCLE_GROUPS];
    id = map[ID];
    name = map[NAME];
  }

  @override
  Map<String, dynamic> toMap() => {
        EXERCISES: availableExercises,
        MUSCLE_GROUPS: muscleGroups,
        ID: id,
        NAME: name,
      };

  @override
  int get typeId => 0;
}
