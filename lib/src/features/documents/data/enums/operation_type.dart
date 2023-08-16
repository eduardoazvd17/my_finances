import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum OperationType {
  buy,
  sell,
}

extension OperationTypeExtension on OperationType {
  String get char => 'operation-type-char-$index'.i18n();
  String get title => 'operation-type-title-$index'.i18n();

  Icon get icon {
    return switch (this) {
      OperationType.buy => const Icon(Icons.attach_money, color: Colors.green),
      OperationType.sell => Icon(Icons.money_off, color: Colors.red[300]),
    };
  }
}
