import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

class SelectedWorkout extends StatelessWidget {
  final String workoutName;
  final String workoutDuration;
  final String workoutEquipment;
  final String workoutMuscleGroups;

  const SelectedWorkout({
    Key? key,
    required this.workoutName,
    required this.workoutDuration,
    required this.workoutEquipment,
    required this.workoutMuscleGroups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.edit),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  workoutName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$workoutDuration Total",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Column(
                  children: [
                    const Text("Equipment:"),
                    Text(workoutEquipment),
                  ],
                ),
                Column(
                  children: [
                    const Text("Muscle Groups:"),
                    Text(workoutMuscleGroups),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
