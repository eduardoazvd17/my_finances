import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/enums/app_language.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class I18nController extends GetxController {
  i18nController() {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  }

  @override
  void onInit() {
    loadSelectedLanguage();
    super.onInit();
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
  Future<void> setSelectedLanguage(AppLanguage? value,
      {bool withoutSaving = false}) async {
    if (!withoutSaving) LoadingWidget.dialog();
    try {
      _selectedLanguage.value = value;
      if (value != null) {
        Get.updateLocale(value.locale);
      } else if (Get.deviceLocale != null) {
        Get.updateLocale(Get.deviceLocale!);
      }

      if (!withoutSaving) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (value != null) {
          await prefs.setInt('AppLanguage', value.index);
        } else {
          await prefs.remove('AppLanguage');
        }
      }
    } catch (_) {}
    if (!withoutSaving) Get.close(1);
  }

  Future<void> loadSelectedLanguage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? index = prefs.getInt('AppLanguage');
      if (index != null) {
        await Future.delayed(const Duration(milliseconds: 300));
        setSelectedLanguage(
          AppLanguage.values[index],
          withoutSaving: true,
        );
      }
    } catch (_) {}
  }

  Locale? get selectedLocale => selectedLanguage?.locale ?? Get.deviceLocale;
}
