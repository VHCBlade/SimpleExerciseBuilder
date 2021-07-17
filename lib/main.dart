import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_exercise_builder/bloc/counter.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_, parentChannel) => CounterBloc(parentChannel: parentChannel),
        child: MaterialApp(
          title: 'Exercise Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Exercise Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
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
