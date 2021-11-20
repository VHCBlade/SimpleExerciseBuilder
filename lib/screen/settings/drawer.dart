import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            right: false,
            child: Column(
              children: const [
                TextButton(onPressed: null, child: Text("About Us")),
                TextButton(
                    onPressed: null, child: Text("Suggest a workout/exercise")),
                TextButton(onPressed: null, child: Text("Report a bug"))
              ],
            )));
  }
}
