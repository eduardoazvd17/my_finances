import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const Color _primaryColor = Colors.indigo;
  static const Color _darkBackgroundColor = Colors.black;

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackgroundColor,
        centerTitle: true,
      ),
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}
