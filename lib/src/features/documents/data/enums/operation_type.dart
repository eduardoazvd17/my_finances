import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum OperationType {
  purchase,
  sell,
}

extension OperationTypeExtension on OperationType {
  String get char => 'operation-type-char-$index'.i18n();
  String get title => 'operation-type-title-$index'.i18n();

  Color get color {
    return switch (this) {
      OperationType.purchase => Colors.green,
      OperationType.sell => Colors.red[300]!,
    };
  }

  Icon get icon {
    return switch (this) {
      OperationType.purchase =>
        Icon(Icons.attach_money, color: color, size: 40),
      OperationType.sell => Icon(Icons.money_off, color: color, size: 40),
    };
  }
}
