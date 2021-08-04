import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/exercise/exercise.dart';

class ExerciseSearchBar extends SliverPersistentHeaderDelegate {
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
            child: ExerciseSearchField(),
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

class ExerciseSearchField extends StatefulWidget {
  const ExerciseSearchField({Key? key}) : super(key: key);

  @override
  _ExerciseSearchFieldState createState() => _ExerciseSearchFieldState();
}

class _ExerciseSearchFieldState extends State<ExerciseSearchField> {
  late final controller = TextEditingController(
      text: BlocProvider.read<ExerciseBloc>(context).searchTerm);

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
            BlocProvider.read<ExerciseBloc>(context).search(val));
  }
}
