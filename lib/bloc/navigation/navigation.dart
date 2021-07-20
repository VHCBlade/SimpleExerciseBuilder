import 'package:event_bloc/event_bloc.dart';
import 'package:simple_exercise_builder/bloc/navigation/event.dart';

const POSSIBLE_NAVIGATION = {'home', 'play', 'workout', 'exercise', 'settings'};

/// This [Bloc] handles the main/top level navigation of this app. Check values in [POSSIBLE_NAVIGATION] for possible main navigation values. You can fire the [MAIN_NAVIGATION_EVENT] and [PREVIOUS_MAIN_NAVIGATION_EVENT] to call the corresponding functions indirectly.
///
/// Defaults to home and will change the main navigation to home if it is attempted to change the app to an unknown state.
class MainNavigationBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;

  String currentMainNavigation = 'home';
  String previousMainNavigation = 'home';

  MainNavigationBloc({BlocEventChannel? parentChannel})
      : eventChannel = BlocEventChannel(parentChannel) {
    eventChannel.addEventListener(MAIN_NAVIGATION_EVENT,
        BlocEventChannel.simpleListener((val) => changeMainNavigation(val)));
    eventChannel.addEventListener(PREVIOUS_MAIN_NAVIGATION_EVENT,
        BlocEventChannel.simpleListener((_) => changeToPreviousNavigation()));
  }

  void changeMainNavigation(String newMainNavigation) {
    if (!POSSIBLE_NAVIGATION.contains(newMainNavigation)) {
      changeMainNavigation('home');
      return;
    }

    if (currentMainNavigation == newMainNavigation) {
      return;
    }

    previousMainNavigation = currentMainNavigation;
    currentMainNavigation = newMainNavigation;
    updateBloc();
  }

  void changeToPreviousNavigation() =>
      changeMainNavigation(previousMainNavigation);
}
