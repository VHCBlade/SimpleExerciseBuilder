import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';

class BlocLayer extends StatelessWidget {
  final Widget child;

  const BlocLayer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_, parentChannel) => CounterBloc(parentChannel: parentChannel),
      child: BlocProvider(
          create: (_, parentChannel) => MainNavigationBloc(), child: child),
    );
  }
}
