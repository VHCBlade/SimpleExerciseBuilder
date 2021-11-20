import 'package:event_bloc/event_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_exercise_builder/bloc/theme.dart';
import 'package:simple_exercise_builder/screen/settings/individual_setting.dart';

class ThemeSettingWidget extends StatelessWidget {
  const ThemeSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<ThemeBloc>(context);

    late final String status;
    switch (bloc.setting) {
      case ThemeSetting.useDevice:
        status = "Use device theme";
        break;
      case ThemeSetting.light:
        status = "Light theme";
        break;
      case ThemeSetting.dark:
      default:
        status = "Dark theme";
    }

    return IndividualSetting(
      name: "Theme",
      status: status,
      onPressed: showThemeSelectionModal,
    );
  }

  void showThemeSelectionModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(child: ThemeSelectionModal()),
    );
  }
}

class ThemeSelectionModal extends StatelessWidget {
  const ThemeSelectionModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.watch<ThemeBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              alignment: Alignment.centerLeft, child: Text("Choose Theme:")),
          const SizedBox(height: 10),
          CupertinoSlidingSegmentedControl<ThemeSetting>(
              children: const {
                ThemeSetting.useDevice: Text("Device Theme"),
                ThemeSetting.light: Text("Light Theme"),
                ThemeSetting.dark: Text("Dark Theme"),
              },
              groupValue: bloc.setting,
              onValueChanged: (val) =>
                  bloc.changeSetting(val ?? ThemeSetting.useDevice)),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK")))
        ],
      ),
    );
  }
}
