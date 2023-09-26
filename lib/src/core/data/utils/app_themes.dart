import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color _primaryColor = Colors.indigo;
  static const Color lightBackgroundColor = Color.fromARGB(255, 221, 227, 231);
  static const Color _lightSecondaryBackgroundColor =
      Color.fromARGB(255, 245, 245, 245);
  static const Color darkBackgroundColor = Colors.black;
  static const Color _darkSecondaryBackgroundColor =
      Color.fromARGB(255, 33, 33, 33);
  static final String? _fontFamilly = GoogleFonts.lato().fontFamily;
  static const Color commonColor = Color.fromARGB(255, 117, 117, 117);

  static const _bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    ),
  );

  static ThemeData get light {
    return ThemeData(
      fontFamily: _fontFamilly,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _primaryColor,
        tertiary: _primaryColor,
        surfaceTint: lightBackgroundColor,
        brightness: Brightness.light,
      ),
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: lightBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: lightBackgroundColor,
        ),
        centerTitle: true,
      ),
      dialogBackgroundColor: _lightSecondaryBackgroundColor,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: darkBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _lightSecondaryBackgroundColor,
        shape: _bottomSheetShape,
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
      fontFamily: _fontFamilly,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        secondary: _primaryColor,
        tertiary: _primaryColor,
        surfaceTint: darkBackgroundColor,
        brightness: Brightness.dark,
      ),
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: darkBackgroundColor,
        ),
        centerTitle: true,
      ),
      dialogBackgroundColor: _darkSecondaryBackgroundColor,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: lightBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
        shape: _bottomSheetShape,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkSecondaryBackgroundColor,
      ),
      dividerColor: commonColor,
      useMaterial3: true,
    );
  }
}
