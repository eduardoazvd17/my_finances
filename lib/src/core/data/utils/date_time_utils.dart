import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../enums/app_date_format.dart';
import '../../presentation/controllers/i18n_controller.dart';

import '../enums/app_language.dart';

class DateTimeUtils {
  static String get _dateLocaleString {
    final i18n = Get.find<I18nController>();
    if (i18n.selectedDateFormat != null) {
      return i18n.selectedDateFormat!.locale;
    } else {
      return _localeString;
    }
  }

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
    final String time = _time(date);
    final String weekDay = _weekDay(date, shortted: true);
    return '$weekDay, ${DateFormat.yMd(_dateLocaleString).format(date)} $time';
  }

  static String formatFullDate(DateTime date) {
    final String time = _time(date);
    final String weekDay = _weekDay(date);
    return '$weekDay, ${DateFormat.yMMMMd(_localeString).format(date)} - $time';
  }

  static String formatDate(DateTime date) {
    final weekDay = _weekDay(date);
    return '$weekDay, ${DateFormat.yMd(_dateLocaleString).format(date)}';
  }

  static String formatShortDate(DateTime date) {
    return DateFormat.yMd(_dateLocaleString).format(date);
  }

  static String format2LinesDate(DateTime date) {
    final String dateString = DateFormat.yMd(_dateLocaleString).format(date);
    final split = dateString.split('/');
    return '${split[0]}/${split[1]}\n${split[2]}';
  }

  static formatMonth(DateTime date) {
    final String dateString = DateFormat.yMMMM(_localeString).format(date);
    return dateString.replaceFirst(
      dateString[0],
      dateString[0].toUpperCase(),
    );
  }

  static String _time(DateTime date) {
    final i18n = Get.find<I18nController>();
    if (!i18n.dateUse24hFormat) {
      if (date.hour < 12) {
        return '${date.hour.toString()}:${date.minute.toString().padLeft(2, '0')} AM';
      } else if (date.hour == 12) {
        return '${date.hour.toString()}:${date.minute.toString().padLeft(2, '0')} PM';
      } else {
        final hourIn12format = date.hour % 12;
        return '${hourIn12format.toString()}:${date.minute.toString().padLeft(2, '0')} PM';
      }
    } else {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
  }

  static String _weekDay(DateTime date, {bool shortted = false}) {
    final weekDay = shortted
        ? DateFormat.E(_localeString).format(date)
        : DateFormat.EEEE(_localeString).format(date);
    return weekDay.replaceFirst(
      weekDay.characters.first,
      weekDay.characters.first.toUpperCase(),
    );
  }
}
