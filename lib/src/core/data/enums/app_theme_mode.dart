import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum AppThemeMode {
  automatic,
  light,
  dark,
}

extension AppThemeExtension on AppThemeMode {
  String get title => 'app-theme-$index'.i18n();

  Icon get icon => switch (this) {
        AppThemeMode.automatic => const Icon(Icons.auto_awesome),
        AppThemeMode.light => const Icon(Icons.sunny, color: Colors.orange),
        AppThemeMode.dark => Icon(
            Icons.nightlight_round_outlined,
            color: Colors.indigo[200],
          ),
      };

  ThemeMode get themeMode => switch (this) {
        AppThemeMode.automatic => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
}
