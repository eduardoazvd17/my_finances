// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/data/enums/app_theme_mode.dart';
import 'package:myfinances/src/core/data/utils/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/loading_widget.dart';

class ThemeController extends GetxController {
  @override
  void onInit() {
    updateWebBackgroundColor();
    _loadSelectedTheme();
    super.onInit();
  }

  final Rx<AppThemeMode> _selectedTheme =
      Rx<AppThemeMode>(AppThemeMode.automatic);
  AppThemeMode get selectedTheme => _selectedTheme.value;
  Future<void> setSelectedTheme(
    AppThemeMode value, {
    bool withoutSaving = false,
  }) async {
    if (!withoutSaving) LoadingWidget.dialog();
    try {
      _selectedTheme.value = value;
      updateWebBackgroundColor();

      if (!withoutSaving) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('AppTheme', value.index);
      }
    } catch (_) {}
    if (!withoutSaving) Get.close(1);
  }

  Future<void> _loadSelectedTheme() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? index = prefs.getInt('AppTheme');
      if (index != null) {
        _selectedTheme.value = AppThemeMode.values[index];
        updateWebBackgroundColor();
      }
    } catch (_) {}
  }

  void updateWebBackgroundColor() {
    try {
      if (kIsWeb) {
        String colorToHexString(Color color) {
          return '#${(color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
        }

        final Color color = switch (selectedTheme) {
          AppThemeMode.automatic =>
            (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark)
                ? AppThemes.darkBackgroundColor
                : AppThemes.lightBackgroundColor,
          AppThemeMode.light => AppThemes.lightBackgroundColor,
          AppThemeMode.dark => AppThemes.darkBackgroundColor,
        };

        js.context.callMethod("setBackgroundColor", [colorToHexString(color)]);
      }
    } catch (_) {}
  }
}
