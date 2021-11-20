import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/screen/settings/drawer.dart';
import 'package:simple_exercise_builder/screen/settings/individual_setting.dart';
import 'package:simple_exercise_builder/screen/settings/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        drawer: const SettingsDrawer(),
        body: ListView(
          children: const [ThemeSettingWidget(), AdSetting()],
        ));
  }
}

class AdSetting extends StatelessWidget {
  const AdSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IndividualSetting(
        name: "Ad Frequency", status: "Every three workouts");
  }
}
