import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfinances/src/core/data/enums/app_currency_format.dart';
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
    final i18n = Get.find<I18nController>();
    if (i18n.selectedCurrencyFormat != null) {
      return i18n.selectedCurrencyFormat!.format(value);
    } else {
      return NumberFormat.simpleCurrency(locale: _localeString).format(value);
    }
  }
}
