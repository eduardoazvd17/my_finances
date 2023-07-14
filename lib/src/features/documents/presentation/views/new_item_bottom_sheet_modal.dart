import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/text_field_widget.dart';

import '../controllers/document_editor_controller.dart';

class NewItemBottomSheetModal extends GetWidget<DocumentEditorController> {
  const NewItemBottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: Icons.format_list_bulleted_add,
      title: 'new-item-button'.i18n(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
