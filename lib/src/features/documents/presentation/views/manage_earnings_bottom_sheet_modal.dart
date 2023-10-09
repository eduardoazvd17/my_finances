import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/widgets/advise_message_widget.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../../data/enums/value_type.dart';
import '../../data/models/item_model.dart';
import '../controllers/document_editor_controller.dart';
import 'add_or_edit_item_bottom_sheet_modal.dart';

class ManageEarningsBottomSheetModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  const ManageEarningsBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: icon,
      title: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('added-earnings-label'.i18n()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _addedEarningsListWidget(context),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ButtonWidget(
                icon: Icons.post_add_rounded,
                text: 'new-earning-button'.i18n(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return AddOrEditItemBottomSheetModal(
                        icon: Icons.post_add_rounded,
                        title: 'new-earning-button'.i18n(),
                        controller: controller,
                        monthlyExpensesValueType: ValueType.earning,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addedEarningsListWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 164),
      child: Obx(
        () {
          if (controller.items
              .cast<MonthlyExpenseControlItemModel>()
              .where((e) => e.valueType == ValueType.earning)
              .isEmpty) {
            return Center(
              child: AdviseMessageWidget(
                icon: icon,
                message: 'empty-earnings-title'.i18n(),
                description: 'empty-earnings-description'.i18n(),
              ),
            );
          }

          return ListView(
            children: controller.items
                .cast<MonthlyExpenseControlItemModel>()
                .where((e) => e.valueType == ValueType.earning)
                .map((e) => _getItemWidget(context, e))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _getItemWidget(
      BuildContext context, MonthlyExpenseControlItemModel item) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) {
                  return AddOrEditItemBottomSheetModal(
                    icon: CupertinoIcons.pencil,
                    title: 'edit-earning-button'.i18n(),
                    controller: controller,
                    itemModel: item,
                    monthlyExpensesValueType: ValueType.earning,
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      if (item.isRecurring) ...[
                        IconButtonWidget(
                          iconSize: 21,
                          tooltip: 'recurring-value-text'.i18n(),
                          icon: CupertinoIcons.calendar_circle,
                          iconColor: AppThemes.commonColor,
                          compactMode: true,
                        ),
                        const SizedBox(width: 5),
                      ],
                      const Icon(CupertinoIcons.pencil),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButtonWidget(
          tooltip: 'delete-value-button'.i18n(),
          icon: Icons.close,
          iconColor: Colors.red,
          compactMode: true,
          onTap: () {
            Get.dialog(
              CustomDialog(
                title: 'delete-value-button'.i18n(),
                content: 'delete-value-confirmation-text'.i18n(),
                invertButtonColor: true,
                onConfirm: () {
                  controller.deleteItem(item);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
