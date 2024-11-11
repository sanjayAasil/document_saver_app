import 'package:flutter/material.dart';

class AppThemeData {
  static final AppThemeData _mInstance = AppThemeData._();

  AppThemeData._();

  factory AppThemeData() => _mInstance;

  static const _primaryColor = Colors.blue;

  static get primaryColor => _primaryColor;

  static ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: _primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      surfaceTintColor: _primaryColor,
      backgroundColor: Colors.transparent,
      indicatorColor: _primaryColor,
    ),
  );
}
