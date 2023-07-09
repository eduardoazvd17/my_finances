import 'package:localization/localization.dart';

enum DocumentOrderType {
  lastModifiedDate,
  alphabetical,
  creationDate,
}

extension DocumentOrderTypeExtension on DocumentOrderType {
  String get title => 'document-order-type-$index'.i18n();
}
