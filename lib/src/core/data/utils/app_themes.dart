import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const Color _primaryColor = Colors.indigo;

  static final Color _lightBackgroundColor = Colors.blueGrey[100]!;
  static final Color _lightSecondaryBackgroundColor = Colors.grey[100]!;

  static const Color _darkBackgroundColor = Colors.black;
  static final Color _darkSecondaryBackgroundColor = Colors.grey[900]!;

  static final Color commonColor = Colors.grey[600]!;

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
      appBarTheme: AppBarTheme(
        backgroundColor: _lightBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
      ),
      dialogBackgroundColor: _lightSecondaryBackgroundColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _lightSecondaryBackgroundColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
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
      shadowColor: _darkSecondaryBackgroundColor,
      dialogBackgroundColor: _darkSecondaryBackgroundColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
      ),
      dividerColor: commonColor,
      useMaterial3: true,
    );
  }
}
