import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/drop_down_button_widget.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_order_type.dart';
import 'package:myfinances/src/features/documents_page/presentation/controllers/documents_controller.dart';
import 'package:myfinances/src/core/data/enums/list_order.dart';

class DocumentsOrderBottomSheetModal extends GetWidget<DocumentsController> {
  const DocumentsOrderBottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      title: 'order-document-button'.i18n(),
      child: Column(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _getFilterTile(context),
                  const Divider(),
                  _getOrderTile(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getFilterTile(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            'by-label'.i18n(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: DropDownButtonWidget<DocumentOrderType>(
            isExpanded: true,
            value: controller.documentOrderType,
            onChanged: (value) {
              if (value != null) {
                controller.documentOrderType = value;
              }
            },
            items: DocumentOrderType.values.map((documentOrderType) {
              return DropdownMenuItem(
                value: documentOrderType,
                child: Text(documentOrderType.title),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _getOrderTile(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            'list-order-label'.i18n(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ),
        Expanded(
          child: DropDownButtonWidget<ListOrder>(
            isExpanded: true,
            value: controller.sortOrder,
            onChanged: (value) {
              if (value != null) {
                controller.sortOrder = value;
              }
            },
            items: ListOrder.values.map((order) {
              return DropdownMenuItem(
                value: order,
                child: Text(order.title),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
