import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/model/workout.dart';

class WorkoutCategoryList extends StatelessWidget {
  final List<Workout> workouts;
  final bool editMode;
  const WorkoutCategoryList({
    Key? key,
    required this.workouts,
    required this.editMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: workouts.map((workout) {
        final leadingWidget = editMode ? const Icon(Icons.drag_handle) : null;

        return Card(
          child: ListTile(
            leading: leadingWidget,
            title: Text(workout.name!, style: theme.textTheme.headline6),
          ),
        );
      }).toList(),
    );
  }
}
