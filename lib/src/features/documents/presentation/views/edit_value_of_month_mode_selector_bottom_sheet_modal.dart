import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../data/enums/month_enum.dart';
import '../../data/models/item_model.dart';
import '../controllers/document_editor_controller.dart';

class EditValueOfMonthModeSelectorBottomSheetModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  final MonthlyExpenseControlItemModel itemModel;
  const EditValueOfMonthModeSelectorBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: icon,
      title: title,
      child: Column(
        children: [
          _getIconTile(
            icon: CupertinoIcons.plus_circle,
            text: 'increment-value-button'.i18n(),
            color: Colors.green,
            onTap: () => _showChangeValueDialog(
              labelAndHint: 'increment-value-button'.i18n(),
              operator: '+',
            ),
          ),
          _getIconTile(
            icon: CupertinoIcons.pencil_circle,
            text: 'overwrite-value-button'.i18n(),
            color: Theme.of(context).primaryColor,
            onTap: () => _showChangeValueDialog(
              labelAndHint: 'overwrite-value-button'.i18n(),
            ),
          ),
          _getIconTile(
            icon: CupertinoIcons.minus_circle,
            text: 'decrement-value-button'.i18n(),
            color: Colors.red,
            onTap: () => _showChangeValueDialog(
              labelAndHint: 'decrement-value-button'.i18n(),
              operator: '-',
            ),
          ),
          _getIconTile(
            icon: CupertinoIcons.refresh_circled,
            text: 'restore-default-value-button'.i18n(),
            color: AppThemes.commonColor,
            onTap: () => _showChangeValueDialog(
              labelAndHint: 'restore-default-value-button'.i18n(),
              operator: 'r',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showChangeValueDialog({
    required String labelAndHint,
    String? operator,
  }) async {
    if (operator == 'r') {
      await controller.changeItemMonthValue(
        itemModel: itemModel,
        selectedMonth: controller.selectedMonth,
        value: null,
        operator: operator,
      );
      return;
    }

    final split = labelAndHint.split('\n');
    final String buttonText = split.isEmpty ? '' : split.first;
    final String hintText = split.isEmpty ? '' : split.last;

    final priceController = TextEditingController(
      text: operator == null
          ? itemModel
              .value(controller.selectedMonth)
              .toStringAsFixed(2)
              .replaceAll('.00', '')
              .replaceAll(',00', '')
          : '',
    );

    Future<void> onConfirm() async {
      final bool? result = await controller.changeItemMonthValue(
        itemModel: itemModel,
        selectedMonth: controller.selectedMonth,
        value: double.tryParse(priceController.text.trim()),
        operator: operator,
      );
      if (result == true) Get.close(1);
    }

    Get.dialog(
      CustomDialog(
        autoClose: false,
        title: title,
        confirmButtonText: buttonText,
        onConfirm: onConfirm,
        closeButtonText: 'cancel-button'.i18n(),
        onClose: () => Get.close(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _textTile(
              label: 'changing-value-of-label'.i18n(),
              data: itemModel.name,
            ),
            const SizedBox(height: 5),
            _textTile(
              label: 'selected-month-label'.i18n(),
              data: controller.selectedMonth.title,
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              autofocus: true,
              label: 'value-text'.i18n(),
              hint: hintText,
              controller: priceController,
              focusNode: FocusNode(),
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onConfirm(),
            ),
            Text(
              operator == '+'
                  ? 'increment-dialog-description-text'.i18n([''])
                  : (operator == '-'
                      ? 'decrement-dialog-description-text'.i18n([''])
                      : 'overwrite-dialog-description-text'.i18n()),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _getIconTile({
    required IconData icon,
    required String text,
    required Color color,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, color: color, size: 40),
            ),
            Expanded(child: Text(text, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }

  Widget _textTile({
    required String label,
    required String data,
    String? description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(data),
          ],
        ),
        if (description != null)
          Text(
            description,
            style: const TextStyle(
              color: AppThemes.commonColor,
            ),
          ),
      ],
    );
  }
}
