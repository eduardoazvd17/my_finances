import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import '../enums/app_language.dart';

class DateTimeUtils {
  static String formatFullDateByLocale(DateTime date) {
    final language = Get.find<I18nController>().selectedLanguage;
    return DateFormat.yMMMMd(language?.localeString ?? "en_US").format(date);
  }
}
