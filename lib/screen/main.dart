import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_bloc/event_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';
import 'package:simple_exercise_builder/bloc/navigation/navigation.dart';
import 'package:simple_exercise_builder/screen/exercise/exercise_list.dart';
import 'package:simple_exercise_builder/screen/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final CarouselController controller;

  @override
  void initState() {
    super.initState();
    controller = CarouselController();
  }

  /// Calculates the aspect ratio of the currently available viewport, to make the carousel take the entire screen.
  double calculateAspectRatio(BuildContext context) {
    final data = MediaQuery.of(context);

    final value = data.size.width /
        (data.size.height -
            data.padding.top -
            data.viewPadding.top -
            data.viewInsets.top -
            data.padding.left -
            data.padding.right);

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final navBloc = BlocProvider.watch<MainNavigationBloc>(context);
    late final int page;

    switch (navBloc.currentMainNavigation) {
      case 'home':
        page = 0;
        break;
      case 'workout':
        page = 1;
        break;
      case 'exercise':
        page = 2;
        break;
      case 'settings':
        page = 3;
        break;
      default:
    }
    Future.delayed(Duration.zero).then((_) => controller.animateToPage(page));

    return CarouselSlider(
      carouselController: controller,
      items: const [
        // Home
        HomeScreen(),
        // Workout
        PlaceholderScreen(),
        // Exercise
        ExerciseList(),
        // Settings
        PlaceholderScreen()
      ],
      options: CarouselOptions(
          autoPlay: false,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          aspectRatio: calculateAspectRatio(context),
          enlargeCenterPage: true,
          onPageChanged: (val, CarouselPageChangedReason reason) {
            if (reason != CarouselPageChangedReason.manual) {
              return;
            }
            late final String nav;
            switch (val) {
              case 0:
                nav = 'home';
                break;
              case 1:
                nav = 'workout';
                break;
              case 2:
                nav = 'exercise';
                break;
              case 3:
              default:
                nav = 'settings';
                break;
            }
            navBloc.changeMainNavigation(nav);
          }),
    );
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
