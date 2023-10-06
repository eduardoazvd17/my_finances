import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/utils/date_time_utils.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../data/enums/operation_type.dart';
import '../controllers/document_editor_controller.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/data/utils/currency_utils.dart';
import '../../data/models/item_model.dart';
import '../../data/enums/document_type.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  final DocumentEditorController documentEditorController;

  const ItemWidget({
    super.key,
    required this.itemModel,
    required this.documentEditorController,
  });

  bool get isSelected => documentEditorController.selectedItem == itemModel;

  @override
  Widget build(BuildContext context) {
    return switch (documentEditorController.documentModel.type) {
      DocumentType.monthlyExpenseControl => _monthlyExpenseControlItemTile(
          context,
        ),
      DocumentType.investmentControl => _investmentControlItemTile(
          context,
        ),
      DocumentType.annotation => _annotationItemTile(
          context,
        ),
      // DocumentType.pointsAndAirlineMiles => _pointsAndAirlineMilesItemTile(
      //     context,
      //   ),
    };
  }

  Widget _monthlyExpenseControlItemTile(BuildContext context) {
    final MonthlyExpenseControlItemModel itemModel =
        this.itemModel as MonthlyExpenseControlItemModel;

    return _itemBaseWidget(
      context: context,
      trailing: Text(
        CurrencyUtils.format(itemModel.defaultValue),
        style: TextStyle(color: Colors.red[300]),
      ),
      middleExpanded: Text(itemModel.name),
    );
  }

  Widget _investmentControlItemTile(BuildContext context) {
    final InvestimentControlItemModel itemModel =
        this.itemModel as InvestimentControlItemModel;
    return ResponsiveBuilder(
      mobileWidget: _itemBaseWidget(
        context: context,
        leading: Icon(
          itemModel.operationType.icon,
          size: 40 * MediaQuery.of(context).textScaleFactor,
          color: itemModel.operationType.color,
        ),
        middleExpanded: Text(itemModel.mobileName),
        trailing: Text(
          DateTimeUtils.format2LinesDate(itemModel.date),
          textAlign: TextAlign.center,
        ),
      ),
      desktopWidget: _itemBaseWidget(
        context: context,
        leading: Icon(
          itemModel.operationType.icon,
          size: 40 * MediaQuery.of(context).textScaleFactor,
          color: itemModel.operationType.color,
        ),
        middleExpanded: Text(itemModel.desktopName),
        trailing: Text(
          DateTimeUtils.formatDate(itemModel.date),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _annotationItemTile(BuildContext context) {
    final AnnotationItemModel itemModel = this.itemModel as AnnotationItemModel;

    return AnimatedOpacity(
      opacity: itemModel.isChecked ? 0.5 : 1,
      duration: const Duration(milliseconds: 300),
      child: _itemBaseWidget(
        context: context,
        onLongPress: () =>
            documentEditorController.toggleIsCheckedAnnotationItem(itemModel),
        leading: itemModel.quantity != null
            ? Text(
                '${itemModel.quantity}x',
                style: TextStyle(
                  color: AppThemes.commonColor,
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
                  color: AppThemes.commonColor,
                  decoration:
                      itemModel.isChecked ? TextDecoration.lineThrough : null,
                ),
              )
            : null,
      ),
    );
  }

  // Widget _pointsAndAirlineMilesItemTile(BuildContext context) {
  //   //final PointsAndAirlineMilesItemModel itemModel = this.itemModel as PointsAndAirlineMilesItemModel;
  //   return _itemBaseWidget(
  //     context: context,
  //   );
  // }

  Widget _itemBaseWidget({
    required BuildContext context,
    void Function()? onLongPress,
    void Function()? onDoubleTap,
    Widget? leading,
    Widget? middleExpanded,
    Widget? trailing,
    Widget? bottom,
  }) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        child: InkWell(
          onLongPress: onLongPress,
          onTap: () {
            if (isSelected) {
              documentEditorController.selectedItem = null;
            } else {
              documentEditorController.selectedItem = itemModel;
            }
          },
          onDoubleTap: onDoubleTap,
          borderRadius: BorderRadius.circular(12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (leading != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: leading,
                        ),
                      if (middleExpanded != null)
                        Expanded(child: middleExpanded),
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
      ),
    );
  }
}
