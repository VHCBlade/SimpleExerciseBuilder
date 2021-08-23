import 'package:event_navigation/event_navigation.dart';

const POSSIBLE_NAVIGATION = {'home', 'play', 'workout', 'exercise', 'settings'};

MainNavigationBloc<String> generateNavigationBloc() {
  return MainNavigationBloc(
    defaultNavigation: 'home',
    strategy: ListNavigationStrategy(
        possibleNavigations: POSSIBLE_NAVIGATION.toList()),
    undoStrategy: UndoRedoMainNavigationStrategy(),
  );
}
