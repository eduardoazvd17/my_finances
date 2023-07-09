import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import '../enums/app_language.dart';

class DateTimeUtils {
  static String get _localeString {
    final language = Get.find<I18nController>().selectedLanguage;
    return language?.localeString ?? "en_US";
  }

  static String formatFullDateShorted(DateTime date) {
    final time = '${date.hour}:${date.minute}';
    final weekDay = DateFormat.E(_localeString).format(date);
    return '$weekDay, ${DateFormat.yMd(_localeString).format(date)} $time';
  }

  static String formatFullDate(DateTime date) {
    final time = '${date.hour}:${date.minute}';
    final weekDay = DateFormat.EEEE(_localeString).format(date);
    return '$weekDay, ${DateFormat.yMMMMd(_localeString).format(date)} - $time';
  }
}
