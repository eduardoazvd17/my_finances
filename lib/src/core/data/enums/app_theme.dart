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

  Color get webFrameBackgroundColor => switch (this) {
        AppTheme.automatic => Colors.grey,
        AppTheme.light => Colors.black,
        AppTheme.dark => Colors.white,
      };
}
