import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../data/enums/app_currency_format.dart';
import '../../data/enums/app_language.dart';
import '../widgets/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/enums/app_date_format.dart';

class I18nController extends GetxController {
  i18nController() {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  }

  @override
  void onInit() {
    _loadSelectedLanguage();
    _loadSelectedCurrencyFormat();
    _loadSelectedDateFormat();
    _loadDateUse24hFormat();
    super.onInit();
  }

  String get appName {
    if (selectedLocale?.languageCode == 'pt') {
      return "Minhas Finanças";
    } else if (selectedLocale?.languageCode == 'es') {
      return "Mis Finanzas";
    } else {
      return "My Finances";
    }
  }

  Iterable<Locale> get supportedLocales =>
      AppLanguage.values.map((e) => e.locale);

  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ];

  Locale? Function(Locale?, Iterable<Locale>) get localeResolutionCallback => (
        locale,
        supportedLocales,
      ) {
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
  Future<void> setSelectedLanguage(
    AppLanguage? value, {
    bool withoutSaving = false,
  }) async {
    if (!withoutSaving) LoadingWidget.dialog();

    _selectedLanguage.value = value;
    if (value != null) {
      Get.updateLocale(value.locale);
    } else if (Get.deviceLocale != null) {
      Get.updateLocale(Get.deviceLocale!);
    }

    if (!withoutSaving) {
      await _saveSelectedLanguage(value);
      Get.close(1);
    }
  }

  Future<void> _saveSelectedLanguage(AppLanguage? appLanguage) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (appLanguage != null) {
        await prefs.setInt('AppLanguage', appLanguage.index);
      } else {
        await prefs.remove('AppLanguage');
      }
    } catch (_) {}
  }

  Future<void> _loadSelectedLanguage() async {
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

  final Rx<AppCurrencyFormat?> _selectedCurrencyFormat =
      Rx<AppCurrencyFormat?>(null);
  AppCurrencyFormat? get selectedCurrencyFormat =>
      _selectedCurrencyFormat.value;
  Future<void> setSelectedCurrencyFormat(
    AppCurrencyFormat? value, {
    bool withoutSaving = false,
  }) async {
    if (!withoutSaving) LoadingWidget.dialog();

    _selectedCurrencyFormat.value = value;
    Get.forceAppUpdate();

    if (!withoutSaving) {
      await _saveSelectedCurrencyFormat(value);
      Get.close(1);
    }
  }

  Future<void> _saveSelectedCurrencyFormat(AppCurrencyFormat? value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value != null) {
        await prefs.setInt('AppCurrencyFormat', value.index);
      } else {
        await prefs.remove('AppCurrencyFormat');
      }
    } catch (_) {}
  }

  Future<void> _loadSelectedCurrencyFormat() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? index = prefs.getInt('AppCurrencyFormat');
      if (index != null) {
        setSelectedCurrencyFormat(
          AppCurrencyFormat.values[index],
          withoutSaving: true,
        );
      }
    } catch (_) {}
  }

  final Rx<AppDateFormat?> _selectedDateFormat = Rx<AppDateFormat?>(null);
  AppDateFormat? get selectedDateFormat => _selectedDateFormat.value;
  Future<void> setSelectedDateFormat(
    AppDateFormat? value, {
    bool withoutSaving = false,
  }) async {
    if (!withoutSaving) LoadingWidget.dialog();

    _selectedDateFormat.value = value;
    Get.forceAppUpdate();

    if (!withoutSaving) {
      await _saveSelectedDateFormat(value);
      Get.close(1);
    }
  }

  Future<void> _saveSelectedDateFormat(AppDateFormat? value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value != null) {
        await prefs.setInt('AppDateFormat', value.index);
      } else {
        await prefs.remove('AppDateFormat');
      }
    } catch (_) {}
  }

  Future<void> _loadSelectedDateFormat() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? index = prefs.getInt('AppDateFormat');
      if (index != null) {
        setSelectedDateFormat(
          AppDateFormat.values[index],
          withoutSaving: true,
        );
      }
    } catch (_) {}
  }

  final Rx<bool> _dateUse24hFormat = Rx<bool>(false);
  bool get dateUse24hFormat => _dateUse24hFormat.value;

  Future<void> setDateUse24hFormat(
    bool value, {
    bool withoutSaving = false,
  }) async {
    if (!withoutSaving) LoadingWidget.dialog();

    _dateUse24hFormat.value = value;
    Get.forceAppUpdate();

    if (!withoutSaving) {
      await _saveDateUse24hFormat(value);
      Get.close(1);
    }
  }

  Future<void> _saveDateUse24hFormat(bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('AppDateUse24hFormat', value);
    } catch (_) {}
  }

  Future<void> _loadDateUse24hFormat() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? value = prefs.getBool('AppDateUse24hFormat');
      setDateUse24hFormat(value ?? false, withoutSaving: true);
    } catch (_) {}
  }
}
