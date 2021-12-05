import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

class SelectedWorkoutWidget extends StatelessWidget {
  final String workoutName;
  final int workoutDuration;
  final List<String> workoutEquipment;
  final List<String> workoutMuscleGroups;

  const SelectedWorkoutWidget({
    Key? key,
    required this.workoutName,
    required this.workoutDuration,
    required this.workoutEquipment,
    required this.workoutMuscleGroups,
  }) : super(key: key);

  String get workoutDurationDisplayText =>
      (workoutDuration / 60).toStringAsFixed(2) + ' minutes';
  String get workoutEquipmentDisplayText => workoutEquipment.join(', ');
  String get workoutMuscleGroupsDisplayText => workoutMuscleGroups.join(', ');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  workoutName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "$workoutDurationDisplayText Total",
                  textAlign: TextAlign.center,
                ),
                Column(
                  children: [
                    const Text("Equipment:"),
                    Text(
                      workoutEquipmentDisplayText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Muscle Groups:"),
                    Text(
                      workoutMuscleGroupsDisplayText,
                      textAlign: TextAlign.center,
                    ),
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
