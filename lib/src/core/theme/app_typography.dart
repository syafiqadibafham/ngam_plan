import 'package:flutter/widgets.dart';

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

  // Font families
  static const String _fontFamily = 'Poppins';

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font sizes
  static const double _displayLarge = 32.0;
  static const double _displayMedium = 28.0;
  static const double _displaySmall = 24.0;
  static const double _headlineLarge = 22.0;
  static const double _headlineMedium = 20.0;
  static const double _headlineSmall = 18.0;
  static const double _titleLarge = 16.0;
  static const double _titleMedium = 14.0;
  static const double _titleSmall = 12.0;
  static const double _bodyLarge = 16.0;
  static const double _bodyMedium = 14.0;
  static const double _bodySmall = 12.0;
  static const double _labelLarge = 14.0;
  static const double _labelMedium = 12.0;
  static const double _labelSmall = 10.0;

  // Display styles
  static TextStyle get displayLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _displayLarge,
        fontWeight: bold,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _displayMedium,
        fontWeight: bold,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _displaySmall,
        fontWeight: bold,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.25,
      );

  // Headline styles
  static TextStyle get headlineLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _headlineLarge,
        fontWeight: semiBold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _headlineMedium,
        fontWeight: semiBold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _headlineSmall,
        fontWeight: semiBold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  // Title styles
  static TextStyle get titleLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _titleLarge,
        fontWeight: medium,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _titleMedium,
        fontWeight: medium,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _titleSmall,
        fontWeight: medium,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // Body styles
  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _bodyLarge,
        fontWeight: regular,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _bodyMedium,
        fontWeight: regular,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _bodySmall,
        fontWeight: regular,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  // Label styles
  static TextStyle get labelLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _labelLarge,
        fontWeight: medium,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _labelMedium,
        fontWeight: medium,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: _labelSmall,
        fontWeight: medium,
        color: AppColors.textSecondary,
        height: 1.4,
      );
}
