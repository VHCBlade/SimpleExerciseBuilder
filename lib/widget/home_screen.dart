import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final String workoutName = "Haron's Workout";
  final String workoutDuration = "30 Minutes";
  final String workoutEquipment = "Pull Up Bar, Balance Board";
  final String workoutMuscleGroups = "Back, Arm, Legs, Abdominal, Chest";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 120,
                bottom: 120,
              ),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            workoutName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$workoutDuration Total",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: [
                              const Text("Equipment:"),
                              Text(workoutEquipment),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Muscle Groups:"),
                              Text(workoutMuscleGroups),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
