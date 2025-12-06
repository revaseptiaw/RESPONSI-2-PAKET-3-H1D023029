import 'package:flutter/material.dart';

final ThemeData brownTheme = ThemeData(
  primarySwatch: Colors.brown,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.brown,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.brown,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
  ),
);
