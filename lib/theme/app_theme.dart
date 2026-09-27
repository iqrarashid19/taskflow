import 'package:flutter/material.dart';

class AppTheme {
  // Main Colors
  static const Color background = Color(0xFFF2F6EF);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color primaryGreen = Color(0xFF064D1F);
  static const Color darkGreen = Color(0xFF18351F);

  static const Color secondaryText = Color(0xFF7C897F);

  // Pastel Colors
  static const Color softGreen = Color(0xFFE5F0E4);
  static const Color softYellow = Color(0xFFF3F0D8);
  static const Color softPink = Color(0xFFF3E5ED);
  static const Color softBlue = Color(0xFFE5EDF2);

  static const Color border = Color(0xFFE0E8DE);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
    ),

    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      foregroundColor: darkGreen,
    ),

    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: primaryGreen,
          width: 1.5,
        ),
      ),
    ),
  );
}