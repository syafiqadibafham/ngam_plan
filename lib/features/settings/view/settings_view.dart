import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/settings/cubit/settings_cubit.dart';
import 'package:ngam_plan/features/settings/cubit/settings_state.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppLocalizations.of(context)!.settingsSectionTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: state.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: (themeMode) => context.read<SettingsCubit>().updateThemeMode(themeMode),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
