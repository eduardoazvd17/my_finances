import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum ValueType {
  earning,
  expense,
}

extension ValueTypeExtension on ValueType {
  String get title => 'value-type-title-$index'.i18n();

  Color get color {
    return switch (this) {
      ValueType.earning => Colors.green,
      ValueType.expense => Colors.red[300]!,
    };
  }

  IconData get icon {
    return switch (this) {
      ValueType.earning => CupertinoIcons.arrow_up_right,
      ValueType.expense => CupertinoIcons.arrow_down_right,
    };
  }
}
