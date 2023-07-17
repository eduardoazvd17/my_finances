import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/drop_down_button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/text_field_widget.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';

import '../../../../core/presentation/widgets/button_widget.dart';
import '../../data/enums/document_type.dart';
import '../controllers/document_editor_controller.dart';

class AddOrEditItemBottomSheetModal extends StatefulWidget {
  final ItemModel? itemModel;
  final GroupingModel? groupingModel;
  final DocumentEditorController controller;

  const AddOrEditItemBottomSheetModal({
    super.key,
    this.itemModel,
    this.groupingModel,
    required this.controller,
  });

  @override
  State<AddOrEditItemBottomSheetModal> createState() =>
      _AddOrEditItemBottomSheetModalState();
}

class _AddOrEditItemBottomSheetModalState
    extends State<AddOrEditItemBottomSheetModal> {
  final _nameFocus = FocusNode();
  late final TextEditingController _nameController;
  GroupingModel? _selectedGrouping;

  bool get isEditing => widget.itemModel != null;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.itemModel?.name ?? '');
    _selectedGrouping = widget.groupingModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: Icons.format_list_bulleted_add,
      title: isEditing ? 'edit-item-button'.i18n() : 'new-item-button'.i18n(),
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
    //TODO: Implementar outros tipos de itens.
    return switch (widget.controller.documentModel.type) {
      DocumentType.monthlyExpenseControl => [],
      DocumentType.investmentControl => [],
      DocumentType.annotation => [
          _nameTextFieldWidget(),
          _groupSelectionWidget(),
          _buttonsWidget(() async {
            return await widget.controller.addOrEditAnnotationItem(
              itemModel: widget.itemModel as AnnotationItemModel?,
              newName: _nameController.text,
              newGroupingId: _selectedGrouping?.id,
              newQuantity: null,
              newPrice: null,
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
      focusNode: _nameFocus,
    );
  }

  Widget _groupSelectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEditing
              ? 'item-change-group-label'.i18n()
              : 'item-group-label'.i18n(),
        ),
        DropDownButtonWidget<GroupingModel?>(
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
                  color: Colors.grey[600],
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
      ],
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
