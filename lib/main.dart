import 'package:expense_tracker/widgets/expense_tracker.dart';
import 'package:flutter/material.dart';

var darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

var colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: darkColorScheme.onPrimaryContainer,
            foregroundColor: darkColorScheme.onPrimary),
        cardTheme: const CardTheme().copyWith(
            color: darkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
            
          backgroundColor: darkColorScheme.primaryContainer,
          foregroundColor: darkColorScheme.onPrimaryContainer,
        )),
        // textTheme: ThemeData().textTheme.copyWith(
        //       bodyLarge: TextStyle(
        //           color: darkColorScheme.onSecondaryContainer,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16),
        //     ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: colorScheme.onPrimaryContainer,
            foregroundColor: colorScheme.onPrimary),
        cardTheme: const CardTheme().copyWith(
            color: colorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: TextStyle(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
      ),
      home: const ExpensesTracker(),
    ),
  );
}
