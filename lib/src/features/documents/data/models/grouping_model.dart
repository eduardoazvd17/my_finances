import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../presentation/widgets/grouping_widget.dart';

class GroupingModel extends Equatable {
  final String id;
  final String name;
  final bool initializeExpanded;
  final DateTime creationDate;

  const GroupingModel({
    required this.id,
    required this.name,
    required this.initializeExpanded,
    required this.creationDate,
  });

  GroupingModel copyWith({
    String? name,
    bool? initializeExpanded,
    DateTime? creationDate,
  }) {
    return GroupingModel(
      id: id,
      name: name ?? this.name,
      initializeExpanded: initializeExpanded ?? this.initializeExpanded,
      creationDate: creationDate ?? this.creationDate,
    );
  }

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
      'name': name,
      'initializeExpanded': initializeExpanded,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory GroupingModel.fromMap(Map<String, dynamic> map) {
    return GroupingModel(
      id: map['id'],
      name: map['name'],
      initializeExpanded: map['initializeExpanded'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
    );
  }

  @override
  List<Object?> get props => [id, name, initializeExpanded, creationDate];
}
