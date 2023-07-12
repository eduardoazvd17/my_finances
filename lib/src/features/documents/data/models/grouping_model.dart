import 'package:get/get.dart';

import '../../../../core/presentation/widgets/grouping_widget.dart';

class GroupingModel {
  final String title;
  final bool initializeExpanded;
  final DateTime creationDate;

  GroupingModel({
    required this.title,
    required this.initializeExpanded,
    required this.creationDate,
  });

  String get id => title.toLowerCase().trim().replaceAll(' ', '_');

  GroupingWidgetController getController() {
    if (Get.isRegistered<GroupingWidgetController>(tag: id)) {
      return Get.find<GroupingWidgetController>(tag: id);
    } else {
      return Get.put(
        GroupingWidgetController(initializeExpanded: initializeExpanded),
        tag: id,
      );
    }
  }
}
