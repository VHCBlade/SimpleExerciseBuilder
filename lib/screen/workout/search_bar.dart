import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/workout/workout.dart';

class WorkoutSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SingleChildScrollView(
      child: Container(
        height: minExtent,
        color: Theme.of(context).canvasColor,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: WorkoutSearchField(),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class WorkoutSearchField extends StatefulWidget {
  const WorkoutSearchField({Key? key}) : super(key: key);

  @override
  _WorkoutSearchFieldState createState() => _WorkoutSearchFieldState();
}

class _WorkoutSearchFieldState extends State<WorkoutSearchField> {
  late final controller = TextEditingController(
      text: BlocProvider.read<WorkoutBloc>(context).searchTerm);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)))),
        onSubmitted: (val) =>
            BlocProvider.read<WorkoutBloc>(context).search(val));
  }
}
