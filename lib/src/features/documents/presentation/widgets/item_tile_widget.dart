import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';

import '../../../../core/data/utils/currency_utils.dart';
import '../../data/models/item_model.dart';
import '../../data/enums/document_type.dart';

class ItemTileWidget extends GetWidget<DocumentEditorController> {
  final ItemModel itemModel;
  const ItemTileWidget({super.key, required this.itemModel});

  bool get isSelected => controller.selectedItem == itemModel;

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          if (isSelected) {
            controller.selectedItem = null;
          } else {
            controller.selectedItem = itemModel;
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Obx(
          () => DecoratedBox(
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
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
