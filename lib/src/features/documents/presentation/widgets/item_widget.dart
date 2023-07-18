import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    //final MonthlyExpenseControlItemModel item = this.item as MonthlyExpenseControlItemModel;
    return Container();
  }

  Widget _investmentControlItemTile(BuildContext context) {
    //final InvestimentControlItemModel item = this.item as InvestimentControlItemModel;
    return Container();
  }

  Widget _annotationItemTile(BuildContext context) {
    final AnnotationItemModel itemModel = this.itemModel as AnnotationItemModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: InkWell(
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
                    if (itemModel.quantity != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          '${itemModel.quantity}x',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    Expanded(child: Text(itemModel.name)),
                    if (itemModel.price != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          CurrencyUtils.format(itemModel.price!),
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
                if (itemModel.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.5),
                    child: Text(
                      itemModel.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pointsAndAirlineMilesItemTile(BuildContext context) {
    //final PointsAndAirlineMilesItemModel item = this.item as PointsAndAirlineMilesItemModel;
    return Container();
  }
}
