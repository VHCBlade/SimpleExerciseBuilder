import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

import 'package:simple_exercise_builder/screen/home/selected_workout.dart';
import 'package:simple_exercise_builder/screen/home/start_workout.dart';

class HomeScreen extends StatelessWidget {
  final String workoutName = "Haron's Workout";
  final String workoutDuration = "30 Minutes";
  final String workoutEquipment = "Pull Up Bar, Balance Board";
  final String workoutMuscleGroups = "Back, Arm, Legs, Abdominal, Chest";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                workoutName: workoutName,
                workoutDuration: workoutDuration,
                workoutEquipment: workoutEquipment,
                workoutMuscleGroups: workoutMuscleGroups,
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
