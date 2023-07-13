import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../presentation/widgets/grouping_widget.dart';

class GroupingModel extends Equatable {
  final String title;
  final bool initializeExpanded;
  final DateTime creationDate;

  const GroupingModel({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'initializeExpanded': initializeExpanded,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory GroupingModel.fromMap(Map<String, dynamic> map) {
    return GroupingModel(
      title: map['title'],
      initializeExpanded: map['initializeExpanded'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
    );
  }

  @override
  List<Object?> get props => [id];
}
