import 'package:equatable/equatable.dart';

import '../../../../core/data/utils/date_time_utils.dart';

class DateModel extends Equatable {
  final int month;
  final int year;

  String get title => DateTimeUtils.formatMonth(asDateTime());

  String get code => "${year}_$month";

  DateTime asDateTime() => DateTime(year, month);

  const DateModel({
    required this.month,
    required this.year,
  });

  @override
  String toString() => code;

  factory DateModel.fromString(String string) {
    final List<String> split = string.trim().split('_');
    final int year = int.parse(split[0]);
    final int month = int.parse(split[1]);
    return DateModel(month: month, year: year);
  }

  @override
  List<Object?> get props => [code];
}
