import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

import 'package:simple_exercise_builder/model/enum.dart';
import 'package:simple_exercise_builder/model/workout.dart';

import 'package:simple_exercise_builder/screen/home/selected_workout.dart';
import 'package:simple_exercise_builder/screen/home/start_workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Workout getSelectedWorkout(BuildContext context) {
    return Workout.fromMap(context, {
      Workout.WORKOUT_ID: 0,
      Workout.NAME: "Haron's Workout",
      Workout.CUSTOM_MESSAGE: "Time for McDo!",
      Workout.EXERCISE_LIST: [
        {
          WorkoutExercise.EXERCISE: 0,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.band,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 30,
          WorkoutExercise.SETS: 5,
          WorkoutExercise.REST_BETWEEN_SETS: 10,
          WorkoutExercise.AFTER_REST: 20,
        },
        {
          WorkoutExercise.EXERCISE: 1,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.barbell,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 20,
          WorkoutExercise.SETS: 3,
          WorkoutExercise.REST_BETWEEN_SETS: 5,
          WorkoutExercise.AFTER_REST: 10,
        },
        {
          WorkoutExercise.EXERCISE: 2,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.barbell,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 5,
          WorkoutExercise.SETS: 2,
          WorkoutExercise.REST_BETWEEN_SETS: 10,
          WorkoutExercise.AFTER_REST: 20,
        },
      ],
    });
  }

  @override
  Widget build(BuildContext context) {
    final workout = getSelectedWorkout(context);

    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 120,
                bottom: 120,
              ),
              child: SelectedWorkout(
                workoutName: workout.name!,
                workoutDuration: workout.totalTime,
                workoutEquipment: workout.equipmentUsed,
                workoutMuscleGroups: workout.muscleGroups,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: StartWorkout(),
          ),
        ],
      ),
    );
  }
}
