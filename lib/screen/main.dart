import 'package:event_bloc/event_bloc.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';
import 'package:simple_exercise_builder/screen/exercise/exercise_list.dart';

const NAVIGATION_OPTIONS = ['home', 'workout', 'exercise', 'settings'];

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainNavigationFullScreenCarousel(
        navigationOptions: NAVIGATION_OPTIONS,
        navigationBuilder: (_, navigation) {
          switch (navigation) {
            case 'exercise':
              return const ExerciseList();
            case 'home':
            case 'workout':
            case 'settings':
            default:
              return const PlaceholderScreen();
          }
        });
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<CounterBloc>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${bloc.counter}',
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () => context
                  .read<BlocEventChannel>()
                  .fireEvent(INCREMENT_COUNTER_EVENT, null),
              child: const Text('Increment Counter')),
          ElevatedButton(
              onPressed: () => context
                  .read<BlocEventChannel>()
                  .fireEvent(RESET_COUNTER_EVENT, null),
              child: const Text('Reset Counter')),
        ],
      ),
    );
  }
}
