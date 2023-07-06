import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/enums/app_language.dart';

class I18nController extends GetxController {
  i18nController() {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  }

  Iterable<Locale> get supportedLocales =>
      AppLanguage.values.map((e) => e.locale);

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
          return AppLanguage.portuguese.locale;
        }
        if (locale?.languageCode == 'es') {
          return AppLanguage.spanish.locale;
        }
        return AppLanguage.english.locale;
      };

  final Rx<AppLanguage?> _selectedLanguage = Rx<AppLanguage?>(null);
  AppLanguage? get selectedLanguage => _selectedLanguage.value;
  set selectedLanguage(AppLanguage? value) {
    _selectedLanguage.value = value;
    if (value != null) {
      Get.updateLocale(value.locale);
    } else if (Get.deviceLocale != null) {
      Get.updateLocale(Get.deviceLocale!);
    }
  }

  Locale? get selectedLocale => selectedLanguage?.locale ?? Get.deviceLocale;
}
