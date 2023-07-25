import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/button_widget.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';

import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../controllers/document_editor_controller.dart';

class AddOrEditGroupBottomSheetModal extends StatefulWidget {
  final GroupingModel? groupingModel;
  final DocumentEditorController controller;

  const AddOrEditGroupBottomSheetModal({
    super.key,
    this.groupingModel,
    required this.controller,
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
      icon: isEditing ? CupertinoIcons.pencil : Icons.post_add_rounded,
      title: isEditing ? 'edit-group-button'.i18n() : 'new-group-button'.i18n(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildLayout(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLayout(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Column(
          children: [
            _nameTextFieldWidget(),
            _initializeExpandedWidget(),
            _buttonsWidget(),
          ],
        ),
      ),
    ];
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

  Widget _buttonsWidget() {
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
