import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/workout/workout.dart';
import 'package:simple_exercise_builder/model/workout.dart';
import 'package:simple_exercise_builder/screen/workout/search_bar.dart';
import 'package:simple_exercise_builder/screen/workout/workout_category_list.dart';

class WorkoutList extends StatefulWidget {
  final void Function(Workout exercise)? action;
  final bool enableAdding;
  final bool enableModifying;

  const WorkoutList({
    Key? key,
    this.action,
    this.enableAdding = true,
    this.enableModifying = true,
  }) : super(key: key);

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  bool editMode = false;

  void createWorkout() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<WorkoutBloc>(context);
    final workoutMap = bloc.workoutMap;
    final workoutList = bloc.workoutList
        .map((workoutID) => workoutMap[workoutID])
        .where((workout) => workout != null);
    final userMadeWorkouts = workoutList.where((workout) => workout!.userMade);
    final preMadeWorkouts = workoutList.where((workout) => !workout!.userMade);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Workouts')),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(floating: true, delegate: WorkoutSearchBar()),
          SliverList(
            delegate: SliverChildListDelegate([
              WorkoutCategoryGroup(
                action: widget.action,
                category: 'Your Workouts',
                workouts: List.from(userMadeWorkouts),
                editMode: editMode,
              ),
              WorkoutCategoryGroup(
                action: widget.action,
                category: 'Try These Workouts',
                workouts: List.from(preMadeWorkouts),
                editMode: editMode,
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: widget.enableAdding
          ? FloatingActionButton(
              onPressed: createWorkout,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class WorkoutCategoryGroup extends StatefulWidget {
  final void Function(Workout)? action;
  final String category;
  final List<Workout> workouts;
  final bool editMode;

  const WorkoutCategoryGroup({
    Key? key,
    required this.action,
    required this.category,
    required this.workouts,
    required this.editMode,
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
              label: '${widget.category} (${widget.workouts.length})',
              onExpand: () => setState(() => isExpanded = !isExpanded),
            ),
            SizeTransition(
              axisAlignment: -1,
              sizeFactor: animation,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: WorkoutCategoryList(
                  workouts: widget.workouts,
                  editMode: widget.editMode,
                  action: widget.action,
                ),
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
