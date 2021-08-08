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
  final set = convertIntToMuscleGroups(exercise.muscleGroups!);

  final iterable = set.map((val) {
    switch (val) {
      case MuscleGroup.abdominals:
        return 'Abdominals';
      case MuscleGroup.arms:
        return 'Arms';
      case MuscleGroup.back:
        return 'Back';
      case MuscleGroup.chest:
        return 'Chest';
      case MuscleGroup.shoulders:
        return 'Shoulders';
      case MuscleGroup.legs:
      default:
        return 'Legs';
    }
  });

  return iterable.reduce((value, element) => '$value, $element');
}

String generateExerciseEquipmentText(Exercise exercise) {
  final set = convertIntToExerciseEquipment(exercise.muscleGroups!);

  final iterable = set.map((val) {
    switch (val) {
      case ExerciseEquipment.balance:
        return 'Balance Board';
      case ExerciseEquipment.band:
        return 'Exercise Band';
      case ExerciseEquipment.barbell:
        return 'Barbell';
      case ExerciseEquipment.dumbbell:
        return 'Dumbbell';
      case ExerciseEquipment.kettlebell:
        return 'Kettlebell';
      case ExerciseEquipment.pullup:
        return 'Pull Up Bar';
      case ExerciseEquipment.none:
      default:
        return 'None';
    }
  });

  return iterable.reduce((value, element) => '$value, $element');
}
