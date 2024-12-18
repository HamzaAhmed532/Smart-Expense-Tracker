import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme.light(
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFCFDF6),
  onSurface: Color(0xFF1A1C18),
  outline: Color(0xFFC2C8BC), // Changed outlineVariant to outline
  shadow: Color(0xFF000000),
);

const darkColorScheme = ColorScheme.dark(
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFCFDF6),
  onSurface: Color(0xFF1A1C18),
  outline: Color(0xFFC2C8BC), // Changed outlineVariant to outline
  shadow: Color(0xFF000000),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Button background color
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white), // Button text color
      elevation: WidgetStateProperty.all<double>(5.0), // Button shadow
      padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners for the button
        ),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
);
