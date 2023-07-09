import 'package:localization/localization.dart';

enum DocumentFilterType {
  lastModifiedDate,
  alphabetical,
  creationDate,
}

extension DocumentFilterTypeExtension on DocumentFilterType {
  String get title => 'document-filter-type-$index'.i18n();
}
