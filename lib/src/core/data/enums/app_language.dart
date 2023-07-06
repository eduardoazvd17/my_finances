import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

enum AppLanguage {
  english,
  portuguese,
  spanish,
}

extension AppLanguageExtension on AppLanguage {
  String get localeString => '${locale.languageCode}_${locale.countryCode}';

  Locale get locale {
    return switch (this) {
      AppLanguage.english => const Locale('en', 'US'),
      AppLanguage.portuguese => const Locale('pt', 'BR'),
      AppLanguage.spanish => const Locale('es', 'ES')
    };
  }

  String get title => 'app-language-$index'.i18n();
}
