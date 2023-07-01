import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

class I18nController extends GetxController {
  i18nController() {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  }

  Iterable<Locale> get supportedLocales => const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ];

  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ];

  Locale? Function(Locale?, Iterable<Locale>) get localeResolutionCallback =>
      (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }
        if (locale?.languageCode == 'pt') {
          return const Locale('pt', 'BR');
        }
        if (locale?.languageCode == 'es') {
          return const Locale('es', 'ES');
        }
        return const Locale('en', 'US');
      };

  final Rx<Locale?> _selectedLanguage = Rx<Locale?>(null);
  Locale? get selectedLocale => _selectedLanguage.value;
  set selectedLocale(Locale? value) => _selectedLanguage.value = value;
}
