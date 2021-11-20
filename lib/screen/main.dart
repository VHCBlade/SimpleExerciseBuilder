import 'package:event_bloc/event_bloc.dart';
import 'package:event_navigation/event_navigation.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/screen/exercise/exercise_list.dart';
import 'package:simple_exercise_builder/screen/settings/settings.dart';

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
            case 'settings':
              return const SettingsScreen();
            case 'home':
            case 'workout':
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
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            BlocProvider.read<MainNavigationBloc<String>>(context)
                .fullNavigation,
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () => '', child: const Text('Increment Counter')),
          const ElevatedButton(onPressed: null, child: Text('Reset Counter')),
        ],
      ),
    ));
  }
}
