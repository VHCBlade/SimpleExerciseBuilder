import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';
import 'package:simple_exercise_builder/bloc_layer.dart';
import 'package:simple_exercise_builder/repository_layer.dart';
import 'package:simple_exercise_builder/screen/exercise/exercise_list.dart';
import 'package:simple_exercise_builder/widget/navigation.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryLayer(child: BlocLayer(child: AppLayer()));
  }
}

// ignore: use_key_in_widget_constructors
class AppLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Exercise Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<CounterBloc>(context);
    final navBloc = BlocProvider.watch<MainNavigationBloc>(context);
    final navigationBar = MainNavigationBar(
      currentNavigation: navBloc.currentMainNavigation,
      navigationPossibilities: const [
        'home',
        'workout',
        'exercise',
        'settings'
      ],
      builder: (index, onTap) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Workout'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Exercise'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );

    return Scaffold(
      bottomNavigationBar: navigationBar,
      body: navBloc.currentMainNavigation == 'exercise'
          ? const ExerciseList()
          : Center(
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
