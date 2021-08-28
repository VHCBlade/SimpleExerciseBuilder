import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

import 'package:simple_exercise_builder/model/enum.dart';
import 'package:simple_exercise_builder/model/generic.dart';
import 'package:simple_exercise_builder/model/exercise.dart';
import 'package:simple_exercise_builder/bloc/exercise/exercise.dart';

/// Wourkout Exercise details stored within a workout.
class WorkoutExercise implements GenericModel {
  static const EXERCISE = 'exid';
  static const EQUIPMENT_USED = 'equip';
  static const SETS = 'sets';
  static const TIME_IN_SECONDS = 'secs';
  static const REST_BETWEEN_SETS = 'in-rest';
  static const AFTER_REST = 'post-rest';

  BuildContext? context;
  int? exerciseId;
  int? equipmentUsed;
  int? setCount;
  int? time;
  int? restBetween;
  int? restAfter;

  ExerciseBloc? exerciseBloc;

  WorkoutExercise({
    this.context,
    this.exerciseId,
    this.equipmentUsed,
    this.setCount,
    this.time,
    this.restBetween,
    this.restAfter,
  }) {
    if (context != null) {
      exerciseBloc = BlocProvider.read<ExerciseBloc>(context!);
    }
  }

  Exercise get exercise {
    if (exerciseId == null) {
      throw ArgumentError(
          'Exercise ID on Workout Exercise must not be null on runtime');
    }
    if (!exerciseBloc!.exerciseMap.containsKey(exerciseId)) {
      throw ArgumentError('Exercise ID on Workout Exercise is not on Bloc');
    }

    return exerciseBloc!.exerciseMap[exerciseId]!;
  }

  // TODO: Make a better implementation on getting just one equipment name from bitwise value
  // TODO: Validate equipment using repo?
  String get equipmentUsedDisplayName {
    if (equipmentUsed == null) {
      throw ArgumentError(
          'Equipment on Workout Exercise must not be null on runtime');
    }
    if (exercise.availableExercises == null) {
      throw ArgumentError(
          'Equipment of Exercise of Workout Exercise must not be null on runtime.');
    }
    if ((equipmentUsed! & exercise.availableExercises!) == 0) {
      throw ArgumentError(
          'Equipment of Workout Exercise is not available in Exercise.');
    }

    return convertIntToExerciseEquipment(equipmentUsed!)
        .toList()[0]
        .getDisplayText();
  }

  List<String> get muscleGroupDisplayNames {
    return exercise.muscleGroupsSet
        .map((muscleGroup) => muscleGroup.getDisplayText())
        .toList();
  }

  int get totalTime {
    if (time == null) {
      throw ArgumentError(
          'Time on Workout exercise must not be null on runtime');
    } else if (setCount == null) {
      throw ArgumentError(
          'Set count on Workout exercise must not be null on runtime');
    } else if (restBetween == null) {
      throw ArgumentError(
          'Rest in between on Workout exercise must not be null on runtime');
    } else if (restAfter == null) {
      throw ArgumentError(
          'Rest after on Workout exercise must not be null on runtime');
    }

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
}

class Workout implements GenericModel {
  static const EXERCISE_LIST = 'exes';
  static const WORKOUT_ID = 'id';
  static const NAME = 'name';
  static const CUSTOM_MESSAGE = 'custom_message';

  BuildContext? context;
  List<WorkoutExercise> exerciseList = [];
  String? name;
  int? id;
  String? customMessage;

  Workout({this.context, this.name, this.id});

  Workout.fromMap(this.context, Map<String, dynamic> map) {
    loadFromMap(map);
  }

  int get totalTime {
    final exerciseTotalTimes = exerciseList.map((exer) => exer.totalTime);
    return exerciseTotalTimes.fold(
        0, (totalTimeSum, nextTotalTime) => totalTimeSum + nextTotalTime);
  }

  List<String> get equipmentUsed {
    if (exerciseList.isEmpty) {
      return [ExerciseEquipment.none.getDisplayText()];
    }

    final workoutEquipment = exerciseList
        .map((exer) => exer.equipmentUsedDisplayName)
        .toSet()
        .toList();
    workoutEquipment.remove(ExerciseEquipment.none.getDisplayText());
    return workoutEquipment;
  }

  List<String> get muscleGroups {
    if (exerciseList.isEmpty) {
      return [];
    }

    final muscleGroups = exerciseList
        .map((exer) => exer.muscleGroupDisplayNames)
        .expand((muscles) => muscles)
        .toSet()
        .toList();
    return muscleGroups;
  }

  @override
  void loadFromMap(Map<String, dynamic> map) {
    name = map[NAME];
    id = map[WORKOUT_ID];
    customMessage = map[CUSTOM_MESSAGE];
    final List<Map<String, dynamic>> rawExercises = map[EXERCISE_LIST];
    exerciseList = rawExercises
        .map((val) => WorkoutExercise(context: context)..loadFromMap(val))
        .toList();
  }

  @override
  Map<String, dynamic> toMap() {
    final convertedExercises = exerciseList.map((val) => val.toMap()).toList();
    return {NAME: name, WORKOUT_ID: id, EXERCISE_LIST: convertedExercises};
  }

  @override
  int get typeId => 2;
}
