import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/workout/workout.dart';
import 'package:simple_exercise_builder/model/workout.dart';
import 'package:simple_exercise_builder/screen/workout/search_bar.dart';
import 'package:simple_exercise_builder/screen/workout/workout_category_list.dart';

class WorkoutList extends StatelessWidget {
  final void Function(Workout exercise)? action;
  final bool enableAdding;
  final bool enableModifying;

  const WorkoutList({
    Key? key,
    this.action,
    this.enableAdding = true,
    this.enableModifying = true,
  }) : super(key: key);

  void createWorkout() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<WorkoutBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Workouts')),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(floating: true, delegate: WorkoutSearchBar()),
          SliverList(
            delegate: SliverChildListDelegate([
              WorkoutCategoryGroup(
                action: action,
                category: 'Your Workouts',
                workoutIDList: bloc.userCreatedWorkoutList,
                workoutMap: bloc.userCreatedWorkoutMap,
                enableModifying: enableModifying,
              ),
              WorkoutCategoryGroup(
                action: action,
                category: 'Try These Workouts',
                workoutIDList: bloc.preCreatedWorkoutList,
                workoutMap: bloc.preCreatedWorkoutMap,
                enableModifying: false,
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: enableAdding
          ? FloatingActionButton(
              onPressed: createWorkout,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class WorkoutCategoryGroup extends StatefulWidget {
  final void Function(Workout exercise)? action;
  final String category;
  final List<int> workoutIDList;
  final Map<int, Workout> workoutMap;
  final bool enableModifying;

  const WorkoutCategoryGroup({
    Key? key,
    required this.action,
    required this.category,
    required this.workoutIDList,
    required this.workoutMap,
    required this.enableModifying,
  }) : super(key: key);

  @override
  _WorkoutCategoryGroupState createState() => _WorkoutCategoryGroupState();
}

class _WorkoutCategoryGroupState extends State<WorkoutCategoryGroup>
    with SingleTickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: 1,
  );

  late bool isExpanded = true;

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((isExpanded && animation.value != 1) ||
        (!isExpanded && animation.value != 0)) {
      animation.animateTo(isExpanded ? 1 : 0);
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (_, _a) => SafeArea(
        child: Column(
          children: [
            WorkoutCategoryHeader(
              animation: animation,
              label: '${widget.category} (${widget.workoutIDList.length})',
              onExpand: () => setState(() => isExpanded = !isExpanded),
            ),
            SizeTransition(
              axisAlignment: -1,
              sizeFactor: animation,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: WorkoutCategoryList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutCategoryHeader extends StatelessWidget {
  final void Function() onExpand;
  final Animation<double> animation;
  final String label;

  const WorkoutCategoryHeader({
    Key? key,
    required this.animation,
    required this.label,
    required this.onExpand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(label),
            ),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(animation),
              child: IconButton(
                onPressed: onExpand,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
