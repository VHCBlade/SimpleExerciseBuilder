import 'package:event_bloc/event_bloc_no_widgets.dart';
import 'package:simple_exercise_builder/repository/settings/settings_repo.dart';

const THEME_SETTING_TYPE = 'theme-setting';

class ThemeBloc extends Bloc {
  @override
  final BlocEventChannel eventChannel;
  final SettingsRepository repo;

  ThemeSetting setting = ThemeSetting.useDevice;

  ThemeBloc({BlocEventChannel? parentChannel, required this.repo})
      : eventChannel = BlocEventChannel(parentChannel);

  void refreshSetting() async {
    final val = await repo.get<String>(THEME_SETTING_TYPE);

    if (val == null) {
      return;
    }

    final value = ThemeSetting.values.firstWhere(
        (element) => element.toString() == val,
        orElse: () => ThemeSetting.useDevice);

    updateBlocOnChange(change: () => setting = value, tracker: () => [setting]);
  }

  void changeSetting(ThemeSetting setting) {
    if (setting == this.setting) {
      return;
    }
    this.setting = setting;
    repo.set(THEME_SETTING_TYPE, setting.toString());
    updateBloc();
  }
}

enum ThemeSetting { useDevice, light, dark }
