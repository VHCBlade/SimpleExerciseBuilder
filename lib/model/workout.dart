import 'package:simple_exercise_builder/model/enum.dart';
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

  WorkoutExercise.fromMap(Map<String, dynamic> map) {
    loadFromMap(map);
  }

  int get totalTime {
    _assertNotNullOnRuntime(time, 'Time on WorkoutExercise');
    _assertNotNullOnRuntime(setCount, 'Set count on WorkoutExercise');
    _assertNotNullOnRuntime(restBetween, 'Rest inbetween on WorkoutExercise');
    _assertNotNullOnRuntime(restAfter, 'Rest after on WorkoutExercise');

    return ((time! + restBetween!) * setCount!) - restBetween! + restAfter!;
  }

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

  void _assertNotNullOnRuntime(variable, String assertVariableName) {
    assert(
        variable != null, assertVariableName + ' must not be null on runtime');
  }
}

class Workout implements GenericModel {
  static const EXERCISE_LIST = 'exes';
  static const WORKOUT_ID = 'id';
  static const NAME = 'name';
  static const CUSTOM_MESSAGE = 'custom_message';

  List<WorkoutExercise>? exerciseList;
  String? name;
  int? id;
  String? customMessage;

  Workout({this.name, this.id, this.exerciseList, this.customMessage});

  Workout.fromMap(Map<String, dynamic> map) {
    loadFromMap(map);
  }

  int get totalTime {
    final exerciseTotalTimes = exerciseList!.map((exer) => exer.totalTime);
    return exerciseTotalTimes.fold(
        0, (totalTimeSum, nextTotalTime) => totalTimeSum + nextTotalTime);
  }

  @override
  void loadFromMap(Map<String, dynamic> map) {
    name = map[NAME];
    id = map[WORKOUT_ID];
    customMessage = map[CUSTOM_MESSAGE];
    final List<Map<String, dynamic>> rawExercises = map[EXERCISE_LIST];
    exerciseList =
        rawExercises.map((val) => WorkoutExercise.fromMap(val)).toList();
  }

  @override
  Map<String, dynamic> toMap() {
    final convertedExercises = exerciseList!.map((val) => val.toMap()).toList();
    return {NAME: name, WORKOUT_ID: id, EXERCISE_LIST: convertedExercises};
  }

  @override
  int get typeId => 2;
}
