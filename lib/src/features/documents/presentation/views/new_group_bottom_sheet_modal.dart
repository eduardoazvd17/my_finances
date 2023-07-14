import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';

import '../controllers/document_editor_controller.dart';

class NewGroupBottomSheetModal extends GetWidget<DocumentEditorController> {
  const NewGroupBottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: Icons.post_add_rounded,
      title: 'new-group-button'.i18n(),
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
