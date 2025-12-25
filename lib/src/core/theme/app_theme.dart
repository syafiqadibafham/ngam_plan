import 'package:flutter/material.dart';
import 'package:ngam_plan/core/config.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return _glassTheme;
  }

  static ThemeData get darkTheme {
    return _glassTheme;
  }

  static ThemeData get _glassTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white, // Transparent to show gradient wallpaper
      textTheme: AppTypography.textTheme,
      fontFamily: 'Outfit', // Ensure font family is applied globally
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        error: AppColors.error,
        surface: Colors.white,
        onSurface: AppColors.textPrimary,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
      ),
      disabledColor: AppColors.textDisabled,
      cardColor: AppColors.glassSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.glassBorder,
        thickness: 1,
      ),
    );
  }
}
