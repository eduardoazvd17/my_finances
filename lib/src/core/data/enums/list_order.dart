import 'package:localization/localization.dart';

enum ListOrder {
  ascending,
  descending,
}

extension OrderExtension on ListOrder {
  String get title => 'list-order-$index'.i18n();
}
