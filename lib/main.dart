import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';
import 'package:simple_exercise_builder/bloc_layer.dart';
import 'package:simple_exercise_builder/repository_layer.dart';
import 'package:simple_exercise_builder/screen/main.dart';
import 'package:simple_exercise_builder/widget/navigation.dart';
import 'package:simple_exercise_builder/widget/home_screen.dart';

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
      theme: ThemeData(highlightColor: Colors.lightBlue[100]),
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
        resizeToAvoidBottomInset: false,
        body: const MainScreen());
  }
}
