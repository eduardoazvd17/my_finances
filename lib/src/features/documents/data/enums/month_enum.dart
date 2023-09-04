import '../../../../core/data/utils/date_time_utils.dart';

enum MonthEnum {
  jan,
  feb,
  mar,
  apr,
  may,
  june,
  july,
  aug,
  sept,
  oct,
  nov,
  dec,
}

extension MonthEnumExtension on MonthEnum {
  int get toInt => index + 1;
  DateTime get dateTime => DateTime(0, toInt);
  String get title => DateTimeUtils.formatMonth(dateTime);
}
