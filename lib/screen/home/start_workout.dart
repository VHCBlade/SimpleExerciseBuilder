import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

class StartWorkoutWidget extends StatelessWidget {
  const StartWorkoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Ready to break some sweat?",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: Text(
              "Let's Go!",
              style: Theme.of(context).textTheme.headline2,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
