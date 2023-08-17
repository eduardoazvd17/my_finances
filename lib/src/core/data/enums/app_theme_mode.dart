import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum AppThemeMode {
  automatic,
  light,
  dark,
}

extension AppThemeExtension on AppThemeMode {
  String get title => 'app-theme-$index'.i18n();

  ThemeMode get themeMode => switch (this) {
        AppThemeMode.automatic => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
}
