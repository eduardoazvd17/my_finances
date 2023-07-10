import 'package:localization/localization.dart';

enum DocumentOrderType {
  alphabetical,
  lastModifiedDate,
  creationDate,
}

extension DocumentOrderTypeExtension on DocumentOrderType {
  String get title => 'document-order-type-$index'.i18n();
}
