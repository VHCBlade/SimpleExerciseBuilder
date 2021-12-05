import 'package:flutter/material.dart';

import 'package:simple_exercise_builder/model/enum.dart';
import 'package:simple_exercise_builder/model/workout.dart';
import 'package:simple_exercise_builder/screen/routine/routine_player.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<RoutineScreen> {
  bool isPlaying = true;
  Workout? workout;

  _RoutineState() {
    //TODO: Get selected workout
    workout = Workout.fromMap({
      Workout.WORKOUT_ID: 0,
      Workout.NAME: "Haron's Workout",
      Workout.CUSTOM_MESSAGE: "Time for McDo!",
      Workout.EXERCISE_LIST: [
        {
          WorkoutExercise.EXERCISE: 0,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.pullup,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 30,
          WorkoutExercise.SETS: 5,
          WorkoutExercise.REST_BETWEEN_SETS: 10,
          WorkoutExercise.AFTER_REST: 20,
        },
        {
          WorkoutExercise.EXERCISE: 1,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.none,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 20,
          WorkoutExercise.SETS: 3,
          WorkoutExercise.REST_BETWEEN_SETS: 5,
          WorkoutExercise.AFTER_REST: 10,
        },
        {
          WorkoutExercise.EXERCISE: 1,
          WorkoutExercise.EQUIPMENT_USED: convertExerciseEquipmentToInt([
            ExerciseEquipment.balance,
          ]),
          WorkoutExercise.TIME_IN_SECONDS: 5,
          WorkoutExercise.SETS: 2,
          WorkoutExercise.REST_BETWEEN_SETS: 10,
          WorkoutExercise.AFTER_REST: 20,
        },
      ],
    });
  }

  void togglePlayButton() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoutinePlayer(
          isPlaying: isPlaying,
          playButtonPress: togglePlayButton,
        ),
        // RoutineDescription(),
      ],
    );
  }
}
