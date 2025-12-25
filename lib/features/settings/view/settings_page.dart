import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/features/auth/cubit/auth_cubit.dart';
import 'package:ngam_plan/features/settings/cubit/settings_cubit.dart';
import 'package:ngam_plan/features/settings/cubit/settings_state.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildSectionHeader(context, 'Appearance'),
        _buildThemeSetting(context),
        const Divider(),
        _buildSectionHeader(context, 'User'),
        _buildUpdateProfileSetting(context),
        _buildLogoutSetting(context),
        _buildDeleteAccountSetting(context),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildThemeSetting(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return ListTile(
          title: const Text('Theme'),
          subtitle: Text(state.themeMode.name),
          onTap: () async {
            final themeMode = await showDialog<ThemeMode>(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Select Theme'),
                  children: [
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, ThemeMode.system),
                      child: const Text('System Theme'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, ThemeMode.light),
                      child: const Text('Light Theme'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, ThemeMode.dark),
                      child: const Text('Dark Theme'),
                    ),
                  ],
                );
              },
            );
            if (themeMode != null) {
              context.read<SettingsCubit>().updateThemeMode(themeMode);
            }
          },
        );
      },
    );
  }

  Widget _buildUpdateProfileSetting(BuildContext context) {
    return ListTile(
      title: const Text('Update Profile'),
      onTap: () {
        context.go('/settings/update-profile');
      },
    );
  }

  Widget _buildLogoutSetting(BuildContext context) {
    return ListTile(
      title: const Text('Logout'),
      onTap: () {
        context.read<AuthCubit>().signOut();
      },
    );
  }

  Widget _buildDeleteAccountSetting(BuildContext context) {
    return ListTile(
      title: Text(
        'Delete Account',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Delete Account'),
              content: const Text('Are you sure you want to delete your account? This action is irreversible.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().deleteAccount();
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
