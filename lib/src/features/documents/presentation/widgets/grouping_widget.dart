import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_widget.dart';

import '../../data/enums/document_type.dart';
import '../../data/enums/operation_type.dart';
import '../../data/models/grouping_model.dart';
import '../../data/models/item_model.dart';

class GroupingWidget extends GetWidget<DocumentEditorController> {
  final GroupingModel groupingModel;

  const GroupingWidget({
    super.key,
    required this.groupingModel,
  });

  GroupingWidgetController get _controller => groupingModel.getController();

  bool get isSelected => controller.selectedGroup == groupingModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 350),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => DecoratedBox(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            _controller.toggleIsExpanded();
                            if (controller.selectedItem?.groupingId ==
                                groupingModel.id) {
                              controller.selectedItem = null;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              _controller.isExpanded
                                  ? CupertinoIcons.chevron_down
                                  : CupertinoIcons.chevron_right,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (isSelected) {
                              controller.selectedGroup = null;
                            } else {
                              controller.selectedGroup = groupingModel;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            child: Text(groupingModel.name),
                          ),
                        ),
                      ),
                      _trailingWidgetByDocumentType(),
                    ],
                  ),
                  if (_controller.isExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller
                            .getItemsByGroup(groupingModel.id)
                            .map((itemModel) {
                          return ItemWidget(itemModel: itemModel);
                        }).toList(),
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _trailingWidgetByDocumentType() {
    final itemsByGroup = controller.getItemsByGroup(groupingModel.id);

    //TODO: Gropuping trailing para cada tipo de DocumentType.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: switch (controller.documentModel.type) {
        DocumentType.monthlyExpenseControl => Container(),
        DocumentType.investmentControl => Text(
            '${itemsByGroup.isEmpty ? 0 : itemsByGroup.cast<InvestimentControlItemModel>().map(
                  (e) => switch (e.operationType) {
                    OperationType.buy => e.quantity,
                    OperationType.sell => -e.quantity,
                  },
                ).reduce((a, b) => a + b)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        DocumentType.annotation => Text(
            '${itemsByGroup.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        DocumentType.pointsAndAirlineMiles => Container(),
      },
    );
  }
}

class GroupingWidgetController extends GetxController {
  GroupingWidgetController({bool initializeExpanded = false}) {
    _isExpanded = RxBool(initializeExpanded);
  }

  late final RxBool _isExpanded;
  bool get isExpanded => _isExpanded.value;
  void toggleIsExpanded() => _isExpanded.value = !isExpanded;
}
