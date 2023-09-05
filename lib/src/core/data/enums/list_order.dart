import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

enum ListOrder {
  ascending,
  descending,
}

extension OrderExtension on ListOrder {
  String get title => 'list-order-$index'.i18n();
  Icon get icon => switch (this) {
        ListOrder.ascending => const Icon(CupertinoIcons.sort_up),
        ListOrder.descending => const Icon(CupertinoIcons.sort_down),
      };
}
