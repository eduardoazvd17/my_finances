import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const Color _primaryColor = Colors.indigo;

  static const Color _lightBackgroundColor = Color.fromARGB(255, 221, 227, 231);
  static const Color _lightSecondaryBackgroundColor =
      Color.fromARGB(255, 245, 245, 245);

  static const Color _darkBackgroundColor = Colors.black;
  static const Color _darkSecondaryBackgroundColor =
      Color.fromARGB(255, 33, 33, 33);

  static const Color commonColor = Color.fromARGB(255, 117, 117, 117);

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _primaryColor,
        tertiary: _primaryColor,
        surfaceTint: _lightBackgroundColor,
        brightness: Brightness.light,
      ),
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _lightBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
      ),
      dialogBackgroundColor: _lightSecondaryBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _lightSecondaryBackgroundColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _lightSecondaryBackgroundColor,
      ),
      dividerColor: commonColor,
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _primaryColor,
        tertiary: _primaryColor,
        surfaceTint: _darkBackgroundColor,
        brightness: Brightness.dark,
      ),
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
      ),
      dialogBackgroundColor: _darkSecondaryBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
      ),
      dividerColor: commonColor,
      useMaterial3: true,
    );
  }
}
