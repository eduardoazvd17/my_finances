import 'package:flutter/cupertino.dart';
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

  IconData get icon {
    return switch (this) {
      OperationType.purchase => Icons.arrow_drop_up,
      OperationType.sell => Icons.arrow_drop_down,
    };
  }
}
