import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum ListOrder {
  ascending,
  descending,
}

extension OrderExtension on ListOrder {
  String get title => 'list-order-$index'.i18n();
  Icon get icon => switch (this) {
        ListOrder.ascending => const Icon(Icons.arrow_upward),
        ListOrder.descending => const Icon(Icons.arrow_downward),
      };
}
