import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';
import 'package:simple_exercise_builder/bloc_layer.dart';
import 'package:simple_exercise_builder/widget/navigation.dart';
import 'package:simple_exercise_builder/widget/home_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocLayer(child: AppLayer());
  }
}

// ignore: use_key_in_widget_constructors
class AppLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navBloc = BlocProvider.watch<MainNavigationBloc>(context);

    late final MaterialColor color;
    switch (navBloc.currentMainNavigation) {
      case 'home':
        color = Colors.blue;
        break;
      case 'play':
        color = Colors.orange;
        break;
      case 'workout':
        color = Colors.green;
        break;
      case 'exercise':
        color = Colors.red;
        break;
      case 'settings':
      default:
        color = Colors.pink;
        break;
    }

    return MaterialApp(
        title: 'Exercise Demo',
        theme: ThemeData(
          primarySwatch: color,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Exercise Demo Home Page'),
          ),
          bottomNavigationBar: MainNavigationBar(
            currentNavigation: navBloc.currentMainNavigation,
            navigationPossibilities: const [
              'home',
              'play',
              'workout',
              'exercise',
              'settings',
            ],
            builder: (index, onTap) => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              onTap: onTap,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.play_arrow), label: 'Play'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.work), label: 'Workout'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.note), label: 'Exercise'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
          body: HomeScreen(),
        ));
  }
}
