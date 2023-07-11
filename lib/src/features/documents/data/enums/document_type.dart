import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

enum DocumentType {
  monthlyExpenseControl,
  investmentControl,
  annotation,
  pointsAndAirlineMiles,
}

extension DocumentTypeExtension on DocumentType {
  String get title => "document-type-title-$index".i18n();
  String get description => "document-type-description-$index".i18n();
  IconData get icon {
    return switch (this) {
      DocumentType.monthlyExpenseControl => CupertinoIcons.money_dollar,
      DocumentType.investmentControl => CupertinoIcons.chart_bar_alt_fill,
      DocumentType.annotation => CupertinoIcons.doc_plaintext,
      DocumentType.pointsAndAirlineMiles => Icons.airplane_ticket_outlined,
    };
  }
}
