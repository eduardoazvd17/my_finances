import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/button_widget.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';

import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../data/enums/document_type.dart';
import '../controllers/document_editor_controller.dart';

class AddOrEditGroupBottomSheetModal extends StatefulWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  final GroupingModel? groupingModel;

  const AddOrEditGroupBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    this.groupingModel,
  });

  @override
  State<AddOrEditGroupBottomSheetModal> createState() =>
      _AddOrEditGroupBottomSheetModalState();
}

class _AddOrEditGroupBottomSheetModalState
    extends State<AddOrEditGroupBottomSheetModal> {
  late final TextEditingController _nameController;
  late bool _initializeExpanded;

  bool get isEditing => widget.groupingModel != null;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.groupingModel?.name ?? '',
    );
    _initializeExpanded = widget.groupingModel?.initializeExpanded ?? false;
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
              children: _buildLayoutByDocumentType(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLayoutByDocumentType(BuildContext context) {
    //TODO: Implementar outros tipos de itens.
    return switch (widget.controller.documentModel.type) {
      DocumentType.monthlyExpenseControl => [],
      DocumentType.investmentControl => [],
      DocumentType.annotation => [
          _nameTextFieldWidget(),
          _initializeExpandedWidget(),
          _buttonsWidget(
            nameValidationError: 'group-name-validation'.i18n(),
          ),
        ],
      DocumentType.pointsAndAirlineMiles => [],
    };
  }

  TextFieldWidget _nameTextFieldWidget() {
    return TextFieldWidget(
      label:
          isEditing ? 'group-rename-label'.i18n() : 'group-name-label'.i18n(),
      hint: isEditing ? 'group-rename-hint'.i18n() : 'group-name-hint'.i18n(),
      controller: _nameController,
      textCapitalization: TextCapitalization.sentences,
      focusNode: FocusNode(),
    );
  }

  SwitchListTile _initializeExpandedWidget() {
    return SwitchListTile(
      value: _initializeExpanded,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {
          _initializeExpanded = value;
        });
      },
      title: Text('start-expanded-button'.i18n()),
    );
  }

  Widget _buttonsWidget({
    required String nameValidationError,
  }) {
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
                final bool result = await widget.controller.addOrEditGrouping(
                  groupingModel: widget.groupingModel,
                  newName: _nameController.text.trim(),
                  newInitializeExpanded: _initializeExpanded,
                  nameValidationError: nameValidationError,
                );
                if (result) Get.close(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
