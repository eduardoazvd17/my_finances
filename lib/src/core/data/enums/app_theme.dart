import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum AppTheme {
  automatic,
  light,
  dark,
}

extension AppThemeExtension on AppTheme {
  String get title => 'app-theme-$index'.i18n();

  ThemeMode get themeMode => switch (this) {
        AppTheme.automatic => ThemeMode.system,
        AppTheme.light => ThemeMode.light,
        AppTheme.dark => ThemeMode.dark,
      };
}
