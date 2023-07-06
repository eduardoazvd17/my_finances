import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import '../enums/app_language.dart';

class DateTimeUtils {
  static String formatLocale({
    required DateTime date,
  }) {
    final language = Get.find<I18nController>().selectedLanguage;
    if (language == AppLanguage.english) {
      return DateFormat('MMM dd yyyy').format(date);
    }
    return DateFormat('dd MMM yyyy').format(date);
  }
}
