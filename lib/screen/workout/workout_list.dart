import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/workout/workout.dart';
import 'package:simple_exercise_builder/model/workout.dart';
import 'package:simple_exercise_builder/screen/workout/search_bar.dart';
import 'package:simple_exercise_builder/screen/workout/workout_category_list.dart';

class WorkoutListScreen extends StatefulWidget {
  final void Function(Workout exercise)? action;
  final bool enableAdding;
  final bool enableModifying;

  const WorkoutListScreen({
    Key? key,
    this.action,
    this.enableAdding = true,
    this.enableModifying = true,
  }) : super(key: key);

  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<WorkoutBloc>(context);
    final appBarActions = <Widget>[];

    if (widget.enableModifying && !editMode) {
      appBarActions.add(
        IconButton(
          onPressed: () => setState(() => editMode = true),
          icon: const Icon(Icons.edit),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          if (widget.enableModifying && !editMode)
            IconButton(
              onPressed: () => setState(() => editMode = true),
              icon: const Icon(Icons.edit),
            ),
        ],
        leading: editMode
            ? IconButton(
                onPressed: () => setState(() => editMode = false),
                icon: const Icon(Icons.check),
              )
            : null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(floating: true, delegate: WorkoutSearchBar()),
          SliverList(
            delegate: SliverChildListDelegate([
              WorkoutCategoryGroup(
                action: widget.action,
                category: 'Your Workouts',
                workoutIDs: bloc.userMadeWorkoutList,
                editMode: editMode,
              ),
              WorkoutCategoryGroup(
                action: widget.action,
                category: 'Try These Workouts',
                workoutIDs: bloc.preMadeWorkoutList,
                editMode: editMode,
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: (widget.enableAdding && bloc.searchTerm == null)
          ? FloatingActionButton(
              onPressed: () => bloc.addNewWorkout(),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class WorkoutCategoryGroup extends StatefulWidget {
  final void Function(Workout)? action;
  final String category;
  final List<int> workoutIDs;
  final bool editMode;

  const WorkoutCategoryGroup({
    Key? key,
    required this.action,
    required this.category,
    required this.workoutIDs,
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

    return Column(
      children: [
        WorkoutCategoryHeader(
          animation: animation,
          label: '${widget.category} (${widget.workoutIDs.length})',
          onExpand: () => setState(() => isExpanded = !isExpanded),
        ),
        SizeTransition(
          axisAlignment: -1,
          sizeFactor: animation,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: WorkoutCategoryList(
              workoutIDs: widget.workoutIDs,
              editMode: widget.editMode,
              action: widget.action ?? (_) {},
            ),
          ),
        ),
      ],
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(label),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (_, _a) => RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(animation),
                child: IconButton(
                  onPressed: onExpand,
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
