import 'package:simple_exercise_builder/model/generic.dart';

/// Wourkout Exercise details stored within a workout.
class WorkoutExercise implements GenericModel {
  static const EXERCISE = 'exid';
  static const EQUIPMENT_USED = 'equip';
  static const SETS = 'sets';
  static const TIME_IN_SECONDS = 'secs';
  static const REST_BETWEEN_SETS = 'in-rest';
  static const AFTER_REST = 'post-rest';

  int? exerciseId;
  int? equipmentUsed;
  int? setCount;
  int? time;
  int? restBetween;
  int? restAfter;

  WorkoutExercise({
    this.exerciseId,
    this.equipmentUsed,
    this.setCount,
    this.time,
    this.restBetween,
    this.restAfter,
  });

  @override
  void loadFromMap(Map<String, dynamic> map) {
    exerciseId = map[EXERCISE];
    equipmentUsed = map[EQUIPMENT_USED];
    setCount = map[SETS];
    time = map[TIME_IN_SECONDS];
    restBetween = map[REST_BETWEEN_SETS];
    restAfter = map[AFTER_REST];
  }

  @override
  Map<String, dynamic> toMap() => {
        EXERCISE: exerciseId,
        EQUIPMENT_USED: equipmentUsed,
        SETS: setCount,
        TIME_IN_SECONDS: time,
        REST_BETWEEN_SETS: restBetween,
        AFTER_REST: restAfter,
      };

  @override
  int get typeId => 1;
}

class Workout implements GenericModel {
  static const EXERCISE_LIST = 'exes';
  static const WORKOUT_ID = 'id';
  static const NAME = 'name';
  static const CUSTOM_MESSAGE = 'custom_message';

  List<WorkoutExercise> exerciseList = [];
  String? name;
  int? id;
  String? customMessage;
  bool userMade;

  Workout({this.name, this.id, this.userMade = true});

  @override
  void loadFromMap(Map<String, dynamic> map) {
    name = map[NAME];
    id = map[WORKOUT_ID];
    customMessage = map[CUSTOM_MESSAGE];
    final List<Map<String, dynamic>> rawExercises = map[EXERCISE_LIST];
    exerciseList =
        rawExercises.map((val) => WorkoutExercise()..loadFromMap(val)).toList();
  }

  @override
  Map<String, dynamic> toMap() {
    final convertedExercises = exerciseList.map((val) => val.toMap()).toList();
    return {NAME: name, WORKOUT_ID: id, EXERCISE_LIST: convertedExercises};
  }

  @override
  int get typeId => 2;
}
