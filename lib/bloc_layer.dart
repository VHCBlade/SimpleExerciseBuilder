import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';
import 'package:simple_exercise_builder/bloc/exercise/exercise.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';
import 'package:simple_exercise_builder/repository/exercise_repo.dart';

class BlocLayer extends StatelessWidget {
  final Widget child;

  const BlocLayer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_, parentChannel) => CounterBloc(parentChannel: parentChannel),
      child: BlocProvider(
        create: (_, parentChannel) =>
            MainNavigationBloc(parentChannel: parentChannel),
        child: BlocProvider(
            create: (context, parentChannel) => ExerciseBloc(
                parentChannel: parentChannel,
                repo: context.read<ExerciseRepository>())
              ..loadExercises(),
            child: child),
      ),
    );
  }
}
