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

class ManageExpensesBottomSheetModal extends StatefulWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  const ManageExpensesBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
  });

  @override
  State<ManageExpensesBottomSheetModal> createState() =>
      _ManageExpensesBottomSheetModalState();
}

class _ManageExpensesBottomSheetModalState
    extends State<ManageExpensesBottomSheetModal> {
  bool _organizeByGroup = true;

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: widget.icon,
      title: widget.title,
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
                  Text('added-expenses-label'.i18n()),
                  IconButtonWidget(
                    tooltip: 'organize-expenses-text'.i18n(),
                    icon: _organizeByGroup
                        ? Icons.format_align_justify_rounded
                        : Icons.format_align_left_rounded,
                    compactMode: true,
                    onTap: () {
                      setState(() {
                        _organizeByGroup = !_organizeByGroup;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _addedExpensesListWidget(context),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ButtonWidget(
                icon: Icons.post_add_rounded,
                text: 'new-expense-button'.i18n(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return AddOrEditItemBottomSheetModal(
                        icon: Icons.post_add_rounded,
                        title: 'new-expense-button'.i18n(),
                        controller: widget.controller,
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

  Widget _addedExpensesListWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 164),
      child: Obx(
        () {
          if (widget.controller.items
              .cast<MonthlyExpenseControlItemModel>()
              .where((e) => e.valueType == ValueType.expense)
              .isEmpty) {
            return Center(
              child: AdviseMessageWidget(
                icon: widget.icon,
                message: 'empty-expenses-title'.i18n(),
                description: 'empty-expenses-description'.i18n(),
              ),
            );
          }

          return ListView(
            children: _organizeByGroup
                ? widget.controller.groups.map(
                    (group) {
                      final currentGroupItems = widget.controller
                          .getItemsByGroup(group.id)
                          .cast<MonthlyExpenseControlItemModel>()
                          .where((e) => e.valueType == ValueType.expense);

                      if (currentGroupItems.isEmpty) {
                        return const SizedBox();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${group.name}:',
                            style:
                                const TextStyle(color: AppThemes.commonColor),
                          ),
                          ...currentGroupItems.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _getItemWidget(item),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ).toList()
                : widget.controller.items
                    .cast<MonthlyExpenseControlItemModel>()
                    .where((e) => e.valueType == ValueType.expense)
                    .map((e) => _getItemWidget(e))
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _getItemWidget(MonthlyExpenseControlItemModel item) {
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
                    title: 'edit-expense-button'.i18n(),
                    controller: widget.controller,
                    itemModel: item,
                    groupingModel: widget.controller.groups
                        .where((e) => e.id == item.groupingId)
                        .first,
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
                          tooltip: 'recurring-expense-text'.i18n(),
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
          tooltip: 'delete-expense-button'.i18n(),
          icon: Icons.close,
          iconColor: Colors.red,
          compactMode: true,
          onTap: () {
            Get.dialog(
              CustomDialog(
                title: 'delete-expense-button'.i18n(),
                content: 'delete-expense-confirmation-text'.i18n(),
                invertButtonColor: true,
                onConfirm: () {
                  widget.controller.deleteItem(item);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
