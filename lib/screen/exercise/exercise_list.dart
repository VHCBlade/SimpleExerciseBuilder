import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/exercise/exercise.dart';
import 'package:simple_exercise_builder/model/exercise.dart';
import 'package:simple_exercise_builder/screen/exercise/exercise_info.dart';
import 'package:simple_exercise_builder/screen/exercise/search_bar.dart';

class ExerciseList extends StatelessWidget {
  final void Function(Exercise exercise)? action;

  const ExerciseList({Key? key, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<ExerciseBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Exercises')),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(floating: true, delegate: ExerciseSearchBar()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final exercise = bloc.exerciseMap[bloc.exerciseList[i]]!;
                return ExerciseWidget(
                    action: action == null
                        ? () => bloc.selectExercise(
                            bloc.selectedExercise == exercise ? null : exercise)
                        : () => action!(exercise),
                    exercise: exercise);
              },
              childCount: bloc.exerciseList.length,
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseWidget extends StatefulWidget {
  final void Function() action;
  final Exercise exercise;

  const ExerciseWidget({Key? key, required this.action, required this.exercise})
      : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget>
    with SingleTickerProviderStateMixin {
  late final animation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  late bool isSelected = false;

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<ExerciseBloc>(context);
    final theme = Theme.of(context);
    final tween = ColorTween(begin: theme.cardColor, end: theme.highlightColor);

    if (isSelected != (bloc.selectedExercise == widget.exercise)) {
      isSelected = bloc.selectedExercise == widget.exercise;
      animation.animateTo(isSelected ? 1 : 0);
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (_, _a) => SafeArea(
        child: Card(
          color: tween.evaluate(animation),
          child: Column(
            children: [
              MainExerciseWidget(
                action: widget.action,
                animation: animation,
                exercise: widget.exercise,
              ),
              SizeTransition(
                  axisAlignment: -1,
                  sizeFactor: animation,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ExerciseInfo(exercise: widget.exercise)))
            ],
          ),
        ),
      ),
    );
  }
}

class MainExerciseWidget extends StatelessWidget {
  final Animation<double> animation;
  final Exercise exercise;
  final void Function() action;

  const MainExerciseWidget(
      {Key? key,
      required this.animation,
      required this.exercise,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.watch<ExerciseBloc>(context);
    return GestureDetector(
      onTap: action,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(exercise.name!, style: theme.textTheme.headline6)),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(animation),
              child: IconButton(
                onPressed: () => bloc.selectExercise(
                    bloc.selectedExercise == exercise ? null : exercise),
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
