import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/model/workout.dart';

class WorkoutCategoryList extends StatelessWidget {
  final List<Workout> workouts;
  final bool editMode;
  final void Function(Workout)? action;
  const WorkoutCategoryList({
    Key? key,
    this.action,
    required this.workouts,
    required this.editMode,
  }) : super(key: key);

  void viewWorkout(Workout w) {
    // TODO
  }

  void duplicateWorkout(Workout w) {
    // TODO
  }

  void deleteWorkout(Workout w) {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: workouts.map((workout) {
        final leadingWidget = editMode ? const Icon(Icons.drag_handle) : null;
        Widget trailingWidget;

        if (editMode) {
          final editButtons = <Widget>[];

          editButtons.add(IconButton(
            onPressed: () => duplicateWorkout(workout),
            icon: const Icon(Icons.copy),
          ));

          editButtons.add(
            Visibility(
              child: IconButton(
                onPressed: () => deleteWorkout(workout),
                icon: const Icon(Icons.delete),
              ),
              visible: workout.userMade,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
            ),
          );

          trailingWidget = Row(
            children: editButtons,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
          );
        } else {
          trailingWidget = IconButton(
            onPressed: () => viewWorkout(workout),
            icon: const Icon(Icons.chevron_right),
          );
        }

        return Card(
          child: ListTile(
            leading: leadingWidget,
            trailing: trailingWidget,
            title: Text(workout.name!, style: theme.textTheme.headline6),
            subtitle: Text(
              '${(workout.totalTime / 60).floor()} min',
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () => action == null ? null : action!(workout),
          ),
        );
      }).toList(),
    );
  }
}
