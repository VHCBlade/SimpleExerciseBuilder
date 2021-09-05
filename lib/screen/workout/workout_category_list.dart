import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/workout/workout.dart';
import 'package:simple_exercise_builder/model/workout.dart';

class WorkoutCategoryList extends StatelessWidget {
  final List<int> workoutIDs;
  final bool editMode;
  final void Function(Workout) action;
  const WorkoutCategoryList({
    Key? key,
    required this.action,
    required this.workoutIDs,
    required this.editMode,
  }) : super(key: key);

  void viewWorkout(Workout w) {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<WorkoutBloc>(context);
    final workoutMap = bloc.workoutMap;
    final theme = Theme.of(context);

    return Column(
      children: workoutIDs.map((workoutID) {
        final workout = workoutMap[workoutID]!;
        return Card(
          child: ListTile(
            trailing: editMode
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () => bloc.duplicateWorkout(workout),
                        icon: const Icon(Icons.copy),
                      ),
                      Visibility(
                        child: IconButton(
                          onPressed: () => bloc.deleteWorkout(workout),
                          icon: const Icon(Icons.delete),
                        ),
                        visible: workout.userMade,
                        maintainSize: true,
                        maintainState: true,
                        maintainAnimation: true,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                  )
                : IconButton(
                    onPressed: () => viewWorkout(workout),
                    icon: const Icon(Icons.chevron_right),
                  ),
            title: Text(workout.name!, style: theme.textTheme.headline6),
            subtitle: Text(
              '${workout.totalTime.inMinutes} min',
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () => action(workout),
          ),
        );
      }).toList(),
    );
  }
}
