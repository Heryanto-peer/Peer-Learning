import 'package:flutter/material.dart';

class AppTheme {
  // Define a light theme with Material 3
  static final ThemeData lightTheme = ThemeData(
    // Enable Material 3 features
    useMaterial3: true,

    // Set the primary color of the app (seed color for Material 3)
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),

    // Define the text styles used throughout the app
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16.0),
    ),

    // Set the app bar theme
    appBarTheme: const AppBarTheme(
      color: Colors.blue, // Inherit from colorScheme
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Set the button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Inherit from colorScheme
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: const Size(double.maxFinite, 45),
      ),
    ),

    // (Optional) Set the scaffold background color
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(
      constraints: const BoxConstraints(maxWidth: double.maxFinite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  );

// Define a dark theme (optional) with Material 3
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // ... (similar to lightTheme, but with colors suitable for dark mode)
  );
}
