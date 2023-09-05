import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum DocumentOrderType {
  alphabetical,
  creationDate,
}

extension DocumentOrderTypeExtension on DocumentOrderType {
  String get title => 'document-order-type-$index'.i18n();
  Icon get icon => switch (this) {
        DocumentOrderType.alphabetical => const Icon(Icons.abc),
        DocumentOrderType.creationDate => const Icon(CupertinoIcons.calendar),
      };
}
