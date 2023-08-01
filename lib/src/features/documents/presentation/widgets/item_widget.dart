import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/data/utils/date_time_utils.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';

import '../../../../core/data/utils/currency_utils.dart';
import '../../data/models/item_model.dart';
import '../../data/enums/document_type.dart';

class ItemWidget extends GetWidget<DocumentEditorController> {
  final ItemModel itemModel;
  const ItemWidget({super.key, required this.itemModel});

  bool get isSelected => controller.selectedItem == itemModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return switch (controller.documentModel.type) {
        DocumentType.monthlyExpenseControl => _monthlyExpenseControlItemTile(
            context,
          ),
        DocumentType.investmentControl => _investmentControlItemTile(
            context,
          ),
        DocumentType.annotation => _annotationItemTile(
            context,
          ),
        DocumentType.pointsAndAirlineMiles => _pointsAndAirlineMilesItemTile(
            context,
          ),
      };
    });
  }

  Widget _monthlyExpenseControlItemTile(BuildContext context) {
    //final MonthlyExpenseControlItemModel itemModel = this.itemModel as MonthlyExpenseControlItemModel;
    return _itemBaseWidget(
      context: context,
    );
  }

  Widget _investmentControlItemTile(BuildContext context) {
    final InvestimentControlItemModel itemModel =
        this.itemModel as InvestimentControlItemModel;
    return _itemBaseWidget(
      context: context,
      middleExpanded: Text(itemModel.name),
      trailing: Text(
        DateTimeUtils.formatShortDate(itemModel.date),
      ),
    );
  }

  Widget _annotationItemTile(BuildContext context) {
    final AnnotationItemModel itemModel = this.itemModel as AnnotationItemModel;

    return _itemBaseWidget(
      context: context,
      leading: itemModel.quantity != null
          ? Text(
              '${itemModel.quantity}x',
              style: TextStyle(
                color: Colors.grey[600],
                decoration:
                    itemModel.isChecked ? TextDecoration.lineThrough : null,
              ),
            )
          : null,
      trailing: itemModel.price != null
          ? Text(
              CurrencyUtils.format(itemModel.price!),
              style: TextStyle(
                color: Colors.green,
                decoration:
                    itemModel.isChecked ? TextDecoration.lineThrough : null,
              ),
            )
          : null,
      middleExpanded: Text(
        itemModel.name,
        style: TextStyle(
          decoration: itemModel.isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      bottom: itemModel.description != null
          ? Text(
              itemModel.description!,
              style: TextStyle(
                color: Colors.grey[600],
                decoration:
                    itemModel.isChecked ? TextDecoration.lineThrough : null,
              ),
            )
          : null,
    );
  }

  Widget _pointsAndAirlineMilesItemTile(BuildContext context) {
    //final PointsAndAirlineMilesItemModel itemModel = this.itemModel as PointsAndAirlineMilesItemModel;
    return _itemBaseWidget(
      context: context,
    );
  }

  Widget _itemBaseWidget({
    required BuildContext context,
    void Function()? onLongPress,
    Widget? leading,
    Widget? middleExpanded,
    Widget? trailing,
    Widget? bottom,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: () {
          if (isSelected) {
            controller.selectedItem = null;
          } else {
            controller.selectedItem = itemModel;
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (leading != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: leading,
                      ),
                    if (middleExpanded != null) Expanded(child: middleExpanded),
                    if (trailing != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: trailing,
                      ),
                  ],
                ),
                if (bottom != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.5),
                    child: bottom,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
