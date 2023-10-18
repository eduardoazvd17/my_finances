import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../controllers/document_editor_controller.dart';
import 'item_widget.dart';

import '../../data/enums/document_type.dart';
import '../../data/enums/operation_type.dart';
import '../../data/models/grouping_model.dart';
import '../../data/models/item_model.dart';

class GroupingWidget extends StatelessWidget {
  final GroupingModel groupingModel;
  final DocumentEditorController documentEditorController;

  const GroupingWidget({
    super.key,
    required this.groupingModel,
    required this.documentEditorController,
  });

  GroupingWidgetController get _controller => groupingModel.getController();

  bool get isSelected =>
      documentEditorController.selectedGroup == groupingModel;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        curve: Curves.ease,
        duration: const Duration(milliseconds: 350),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            _controller.toggleIsExpanded();
                            if (documentEditorController
                                    .selectedItem?.groupingId ==
                                groupingModel.id) {
                              documentEditorController.selectedItem = null;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
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
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (isSelected) {
                              documentEditorController.selectedGroup = null;
                            } else {
                              documentEditorController.selectedGroup =
                                  groupingModel;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 15,
                                  ),
                                  child: Text(groupingModel.name),
                                ),
                              ),
                              _trailingWidgetByDocumentType(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_controller.isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.5,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: documentEditorController
                            .getItemsByGroup(groupingModel.id,
                                month: documentEditorController.selectedMonth)
                            .map((itemModel) {
                          return ItemWidget(
                            itemModel: itemModel,
                            documentEditorController: documentEditorController,
                          );
                        }).toList(),
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _trailingWidgetByDocumentType() {
    final itemsByGroup =
        documentEditorController.getItemsByGroup(groupingModel.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: switch (documentEditorController.documentModel.type) {
        DocumentType.monthlyExpenseControl => Container(),
        DocumentType.investmentControl => Text(
            '${itemsByGroup.isEmpty ? 0 : itemsByGroup.cast<InvestimentControlItemModel>().map(
                  (e) => switch (e.operationType) {
                    OperationType.purchase => e.quantity,
                    OperationType.sell => -e.quantity,
                  },
                ).reduce((a, b) => a + b)} ${'qtd-text'.i18n()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        DocumentType.annotation => Text(
            '${itemsByGroup.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        //DocumentType.pointsAndAirlineMiles => Container(),
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
