import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/utils/date_time_utils.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/drop_down_button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/text_field_widget.dart';
import 'package:myfinances/src/features/documents/data/enums/operation_type.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../data/enums/document_type.dart';
import '../controllers/document_editor_controller.dart';

class AddOrEditItemBottomSheetModal extends StatefulWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  final ItemModel? itemModel;
  final GroupingModel? groupingModel;

  const AddOrEditItemBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    this.itemModel,
    this.groupingModel,
  });

  @override
  State<AddOrEditItemBottomSheetModal> createState() =>
      _AddOrEditItemBottomSheetModalState();
}

class _AddOrEditItemBottomSheetModalState
    extends State<AddOrEditItemBottomSheetModal> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;
  GroupingModel? _selectedGrouping;
  OperationType? _selectedOperationType;
  DateTime? _selectedDateTime;

  bool get isEditing => widget.itemModel != null;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.itemModel?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.itemModel?.description ?? '');

    switch (widget.controller.documentModel.type) {
      case DocumentType.monthlyExpenseControl:
        break;
      case DocumentType.investmentControl:
        final investiment = widget.itemModel as InvestimentControlItemModel?;
        _selectedOperationType = investiment?.operationType;
        _quantityController = TextEditingController(
          text: investiment?.quantity.toString(),
        );
        _priceController = TextEditingController(
          text: investiment?.price
              .toStringAsFixed(2)
              .replaceAll('.00', '')
              .replaceAll(',00', ''),
        );
        _selectedDateTime = investiment?.date ?? DateTime.now();
        break;
      case DocumentType.annotation:
        final annotation = widget.itemModel as AnnotationItemModel?;
        _quantityController = TextEditingController(
          text: annotation?.quantity?.toString() ?? '',
        );
        _priceController = TextEditingController(
          text: annotation?.price
                  ?.toStringAsFixed(2)
                  .replaceAll('.00', '')
                  .replaceAll(',00', '') ??
              '',
        );
        break;
      case DocumentType.pointsAndAirlineMiles:
        break;
    }
    _selectedGrouping = widget.groupingModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: widget.icon,
      title: widget.title,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildLayoutByDocumentType(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLayoutByDocumentType() {
    //TODO: Layout para cada tipo de DocumentType.
    return switch (widget.controller.documentModel.type) {
      DocumentType.monthlyExpenseControl => [],
      DocumentType.investmentControl => [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Text(
                _selectedGrouping!.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _operationTypeSelectionWidget(),
          Row(
            children: [
              Expanded(
                child: _quantityTextFieldWidget(
                  label: 'asset-quota-quantity-label'.i18n(),
                  optional: false,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'X',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: _priceTextFieldWidget(
                  label: 'asset-quota-price-label'.i18n(),
                  optional: false,
                ),
              ),
            ],
          ),
          _dateTimePickerWidget(),
          _descriptionTextFieldWidget(),
          _buttonsWidget(() async {
            return await widget.controller.addOrEditInvestimentItem(
              itemModel: widget.itemModel as InvestimentControlItemModel?,
              newGroupingId: _selectedGrouping!.id,
              newOperationType: _selectedOperationType,
              newQuantity: int.tryParse(_quantityController.text.trim()),
              newPrice: double.tryParse(
                _priceController.text.trim().replaceAll(',', '.'),
              ),
              newDate: _selectedDateTime ?? DateTime.now(),
              newDescription: _descriptionController.text.trim(),
            );
          }),
        ],
      DocumentType.annotation => [
          _nameTextFieldWidget(),
          _descriptionTextFieldWidget(),
          Row(
            children: [
              Expanded(
                child: _quantityTextFieldWidget(
                  label: 'item-quantity-label'.i18n(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'X',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: _priceTextFieldWidget(
                  label: 'item-price-label'.i18n(),
                ),
              ),
            ],
          ),
          _groupSelectionWidget(),
          _buttonsWidget(() async {
            return await widget.controller.addOrEditAnnotationItem(
              itemModel: widget.itemModel as AnnotationItemModel?,
              newName: _nameController.text.trim(),
              newDescription: _descriptionController.text.trim(),
              newGroupingId: _selectedGrouping?.id,
              newQuantity: int.tryParse(_quantityController.text.trim()),
              newPrice: double.tryParse(
                _priceController.text.trim().replaceAll(',', '.'),
              ),
            );
          }),
        ],
      DocumentType.pointsAndAirlineMiles => [],
    };
  }

  Widget _nameTextFieldWidget() {
    return TextFieldWidget(
      label: isEditing ? 'item-rename-label'.i18n() : 'item-name-label'.i18n(),
      hint: isEditing ? 'item-rename-hint'.i18n() : 'item-name-hint'.i18n(),
      controller: _nameController,
      textCapitalization: TextCapitalization.sentences,
      focusNode: FocusNode(),
    );
  }

  Widget _descriptionTextFieldWidget() {
    return TextFieldWidget(
      label: 'item-description-label'.i18n(),
      hint: 'optional-text'.i18n(),
      controller: _descriptionController,
      textCapitalization: TextCapitalization.sentences,
      focusNode: FocusNode(),
    );
  }

  Widget _quantityTextFieldWidget({
    required String label,
    bool optional = true,
  }) {
    return TextFieldWidget(
      label: label,
      hint: optional ? 'optional-text'.i18n() : '',
      controller: _quantityController,
      textCapitalization: TextCapitalization.none,
      textInputType: const TextInputType.numberWithOptions(decimal: false),
      focusNode: FocusNode(),
    );
  }

  Widget _priceTextFieldWidget({
    required String label,
    bool optional = true,
  }) {
    return TextFieldWidget(
      label: label,
      hint: optional ? 'optional-text'.i18n() : '',
      controller: _priceController,
      textCapitalization: TextCapitalization.none,
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      focusNode: FocusNode(),
    );
  }

  Widget _groupSelectionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing
                ? 'item-change-group-label'.i18n()
                : 'item-group-label'.i18n(),
          ),
          Obx(
            () => DropDownButtonWidget<GroupingModel?>(
              hintText: 'item-group-hint'.i18n(),
              value: _selectedGrouping,
              onChanged: (group) {
                setState(() => _selectedGrouping = group);
              },
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    'item-group-hint'.i18n(),
                    style: TextStyle(
                      color: AppThemes.commonColor,
                    ),
                  ),
                ),
                ...widget.controller.groups.map(
                  (group) {
                    return DropdownMenuItem(
                      value: group,
                      child: Text(
                        group.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _operationTypeSelectionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('operation-type-label'.i18n()),
          DropDownButtonWidget<OperationType?>(
            hintText: 'select-text'.i18n(),
            value: _selectedOperationType,
            onChanged: (operation) {
              setState(() => _selectedOperationType = operation);
            },
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(
                  'select-text'.i18n(),
                  style: TextStyle(
                    color: AppThemes.commonColor,
                  ),
                ),
              ),
              ...OperationType.values.map(
                (operation) {
                  return DropdownMenuItem(
                    value: operation,
                    child: Row(
                      children: [
                        operation.icon,
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            operation.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateTimePickerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('operation-date-picker-label'.i18n()),
                Text(
                  DateTimeUtils.formatDate(_selectedDateTime ?? DateTime.now()),
                  style: TextStyle(color: AppThemes.commonColor),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final DateTime now = DateTime.now();
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDateTime ?? now,
                firstDate: DateTime(2000, 1, 1),
                lastDate: now,
              );
              setState(() {
                _selectedDateTime = pickedDate ?? now;
              });
            },
            icon: const Icon(
              CupertinoIcons.calendar_badge_plus,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonsWidget(Future<bool> Function() onAddOrEdit) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ButtonWidget(
              text: 'cancel-button'.i18n(),
              borderColor: Colors.red,
              foregroundColor: Colors.red,
              onTap: Get.back,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ButtonWidget(
              text: isEditing ? 'save-button'.i18n() : 'add-button'.i18n(),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              onTap: () async {
                final bool result = await onAddOrEdit.call();
                if (result) Get.close(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
