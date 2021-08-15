import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

class StartWorkout extends StatelessWidget {
  const StartWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Ready to break some sweat?",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: const Text(
              "Let's Go!",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
