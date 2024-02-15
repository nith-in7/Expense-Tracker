import 'package:expense_tracker/expense_screen/expenses_screen.dart';
import 'package:flutter/material.dart';

final customColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 61, 17, 143));
final darkScheme =
    ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 140, 27, 239));
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: "Expense Tracker",
      darkTheme: ThemeData.dark().copyWith(colorScheme: darkScheme),
      theme: ThemeData().copyWith(
        colorScheme: customColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: customColorScheme.onPrimaryContainer,
            foregroundColor: customColorScheme.primaryContainer),
        cardTheme: const CardTheme()
            .copyWith(color: customColorScheme.secondaryContainer),
      ),
      home: const ExpensesTracker(),
    ),
  );
}
