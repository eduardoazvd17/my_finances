import 'package:get/get.dart';
import 'package:myfinances/src/core/data/enums/app_theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/loading_widget.dart';

class ThemeController extends GetxController {
  @override
  void onInit() {
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
      }
    } catch (_) {}
  }
}
