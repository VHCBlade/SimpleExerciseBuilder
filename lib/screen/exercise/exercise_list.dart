import 'dart:math';

import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/exercise/exercise.dart';
import 'package:simple_exercise_builder/screen/exercise/search_bar.dart';

class ExerciseList extends StatelessWidget {
  final void Function()? action;

  const ExerciseList({Key? key, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<ExerciseBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(floating: true, delegate: ExerciseSearchBar()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) => Container(
                color: Color(Random().nextInt(0xFFFFFFFF)),
                child: Text(bloc.exerciseMap[bloc.exerciseList[i]]!.name!,
                    style: Theme.of(context).textTheme.headline1)),
            childCount: bloc.exerciseList.length,
          ),
        )
      ]),
    );
  }
}
