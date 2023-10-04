import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../../../core/presentation/widgets/drop_down_button_widget.dart';
import '../../data/enums/document_order_type.dart';
import '../controllers/documents_controller.dart';
import '../../../../core/data/enums/list_order.dart';

class DocumentsOrderBottomSheetModal extends GetWidget<DocumentsController> {
  const DocumentsOrderBottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: Icons.filter_list,
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
          child: Text('by-label'.i18n()),
        ),
        Expanded(
          child: DropDownButtonWidget<DocumentOrderType>(
            isExpanded: true,
            value: controller.documentOrderType,
            onChanged: (value) {
              if (value != null) {
                controller.setDocumentOrderType(value);
              }
            },
            items: DocumentOrderType.values.map((documentOrderType) {
              return DropdownMenuItem(
                value: documentOrderType,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: documentOrderType.icon,
                    ),
                    Expanded(
                      child: Text(
                        documentOrderType.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
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
          child: Text('list-order-label'.i18n()),
        ),
        Expanded(
          child: DropDownButtonWidget<ListOrder>(
            isExpanded: true,
            value: controller.sortOrder,
            onChanged: (value) {
              if (value != null) {
                controller.setSortOrder(value);
              }
            },
            items: ListOrder.values.map((order) {
              return DropdownMenuItem(
                value: order,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: order.icon,
                    ),
                    Expanded(
                      child: Text(
                        order.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
