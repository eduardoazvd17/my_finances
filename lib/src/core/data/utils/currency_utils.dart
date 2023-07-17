import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../enums/app_language.dart';
import '../../presentation/controllers/i18n_controller.dart';

class CurrencyUtils {
  static String get _localeString {
    final i18n = Get.find<I18nController>();
    final language = i18n.selectedLanguage;
    if (language == null &&
        i18n.supportedLocales.contains(i18n.selectedLocale)) {
      return "${i18n.selectedLocale!.languageCode}_${i18n.selectedLocale!.countryCode}";
    } else {
      return language?.localeString ?? "en_US";
    }
  }

  static String format(double value) {
    final format = NumberFormat.simpleCurrency(locale: _localeString);
    return format.format(value);
  }
}
