import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/widgets/expenses.dart';

// If k is the first character of variable it indicating that their values are intended to remain constant throughout the program. Change value will make the whole app change too.
// The fromSeed is auto made the shade of color that we pick

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 0, 116, 110),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 84, 88, 88),
);
void main() {
  runApp(
    MaterialApp(
      // Use this way to overide and custom the default theme

      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: kDarkColorScheme.primaryContainer,
            // Content in side color
            onPrimary: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: kDarkColorScheme.onSecondaryContainer,
        //         fontSize: 14,
        //       ),
        //     ),
      ),
      // Light theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
            ),
      ),
      // To select and set the theme style when start the app
      themeMode: ThemeMode.dark,

      home: const Expenses(),
    ),
  );
}
