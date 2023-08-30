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
  List<Object?> get props => [code];
}
