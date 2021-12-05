import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/model/enum.dart';
import 'package:simple_exercise_builder/model/exercise.dart';

class ExerciseInfo extends StatelessWidget {
  final Exercise exercise;

  const ExerciseInfo({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Muscle Groups', style: theme.textTheme.subtitle2),
        const SizedBox(height: 5),
        Text(generateMuscleGroupText(exercise), textAlign: TextAlign.left),
        const SizedBox(height: 5),
        Text('Equipment Options', style: theme.textTheme.subtitle2),
        const SizedBox(height: 5),
        Text(generateExerciseEquipmentText(exercise),
            textAlign: TextAlign.left),
      ],
    );
  }
}

String generateMuscleGroupText(Exercise exercise) {
  final set = exercise.muscleGroupsSet;

  final iterable = set.map((val) {
    return val.getDisplayText();
  });

  return iterable.reduce((value, element) => '$value, $element');
}

String generateExerciseEquipmentText(Exercise exercise) {
  final set = exercise.availableExerciseEquipment;

  final iterable = set.map((val) {
    return val.getDisplayText();
  });

  return iterable.reduce((value, element) => '$value, $element');
}
