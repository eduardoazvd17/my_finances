import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import '../enums/app_language.dart';

class DateTimeUtils {
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

  static String formatFullDateShorted(DateTime date) {
    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    final weekDay = DateFormat.E(_localeString).format(date);
    return '$weekDay, ${DateFormat.yMd(_localeString).format(date)} $time';
  }

  static String formatFullDate(DateTime date) {
    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    final weekDay = DateFormat.EEEE(_localeString).format(date);
    return '$weekDay, ${DateFormat.yMMMMd(_localeString).format(date)} - $time';
  }
}
