import 'package:flutter/material.dart';

abstract class SettingsState {
  final ThemeMode themeMode;

  const SettingsState(this.themeMode);
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super(ThemeMode.system);
}

class SettingsThemeModeChanged extends SettingsState {
  const SettingsThemeModeChanged(super.themeMode);
}
