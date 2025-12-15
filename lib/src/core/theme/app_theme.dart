import 'package:flutter/material.dart';
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
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.transparent, // Transparent to show gradient wallpaper
      textTheme: AppTypography.textTheme,
      fontFamily: 'Outfit', // Ensure font family is applied globally
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.glassSurface,
        onSurface: AppColors.textPrimary,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
      ),
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
