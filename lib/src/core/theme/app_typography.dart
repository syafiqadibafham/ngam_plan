import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);
  TextStyle withColor(Color color) => copyWith(color: color);
}

class AppTypography {
  // Prevent instantiation
  AppTypography._();

  // Text Theme using GoogleFonts.outfit
  static TextTheme get textTheme {
    return GoogleFonts.outfitTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.2,
          letterSpacing: -1.0,
        ),
        displayMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.2,
          letterSpacing: -0.25,
        ),
        headlineLarge: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
      ),
    );
  }

  // Deprecated individual getters preserved for backward compatibility during refactor
  // Ideally, use Theme.of(context).textTheme...
  static TextStyle get displayLarge => textTheme.displayLarge!;
  static TextStyle get displayMedium => textTheme.displayMedium!;
  static TextStyle get displaySmall => textTheme.displaySmall!;
  
  static TextStyle get headlineLarge => textTheme.headlineLarge!;
  static TextStyle get headlineMedium => textTheme.headlineMedium!;
  static TextStyle get headlineSmall => textTheme.headlineSmall!;
  
  static TextStyle get titleLarge => textTheme.titleLarge!;
  static TextStyle get titleMedium => textTheme.titleMedium!;
  static TextStyle get titleSmall => textTheme.titleSmall!;
  
  static TextStyle get bodyLarge => textTheme.bodyLarge!;
  static TextStyle get bodyMedium => textTheme.bodyMedium!;
  static TextStyle get bodySmall => textTheme.bodySmall!;
  
  static TextStyle get labelLarge => textTheme.labelLarge!;
  static TextStyle get labelMedium => textTheme.labelMedium!;
  static TextStyle get labelSmall => textTheme.labelSmall!;
}
