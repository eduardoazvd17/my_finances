import 'package:localization/localization.dart';

enum DocumentType {
  monthlyExpenseControl,
  investmentControl,
  annotation,
}

extension DocumentTypeExtension on DocumentType {
  String get title => "document-type-title-$index".i18n();
  String get description => "document-type-description-$index".i18n();
}
