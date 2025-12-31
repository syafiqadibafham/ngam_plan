import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // Core Gradient Colors
  static const Color backgroundStart = Color(0xFFfabce3); // Deep Purple
  static const Color backgroundEnd = Color.fromARGB(255, 250, 241, 188); // Darker Indigo
  static const Color accentStart = Color(0xFF2980B9); // Fuchsia Pop
  static const Color accentEnd = Color(0xFF6DD5FA); // Indigo Blue

  // Glass Colors
  static const Color glassSurface = Color.fromARGB(131, 255, 255, 255); // 12% White
  static const Color glassBorder = Color.fromARGB(51, 225, 224, 224); // 20% White
  static const Color glassShadow = Color(0x33000000); // 20% Black

  // Base colors
  static const Color primary = Color(0xFFFFAEC9); // Violet 500
  static const Color secondary = Color(0xFF90EE90); // Teal 500
  static const Color accent = Color(0xFFFFFACD); // Teal 500
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Text colors
  static const Color textPrimary = Color(0xFF404040); // White for dark mode/glass
  static const Color textSecondary = Color(0xB3404040); // 70% White
  static const Color textDisabled = Color.fromARGB(102, 0, 0, 0); // 40% White
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xB3404040);

  // Background colors (Legacy support)
  static const Color backgroundPrimary = Color(0xFF0F0728);
  static const Color backgroundSecondary = Color(0xFF1E1438);
  static const Color backgroundDisabled = Color(0xFF2D2644);
}
