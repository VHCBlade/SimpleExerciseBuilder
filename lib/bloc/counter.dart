import 'package:event_bloc/event_bloc.dart';

const INCREMENT_COUNTER_EVENT = 'increment-counter';
const RESET_COUNTER_EVENT = 'reset-counter';

class CounterBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;
  var counter = 0;

  CounterBloc({BlocEventChannel? parentChannel})
      : eventChannel = BlocEventChannel(parentChannel) {
    eventChannel.addEventListener(INCREMENT_COUNTER_EVENT,
        BlocEventChannel.simpleListener((_) => incrementCounter()));
    eventChannel.addEventListener(RESET_COUNTER_EVENT,
        BlocEventChannel.simpleListener((_) => resetCounter()));
  }

  void incrementCounter() {
    counter++;
    updateBloc();
  }

  void resetCounter() {
    updateBlocOnChange(change: () => counter = 0, tracker: () => [counter]);
  }
}
