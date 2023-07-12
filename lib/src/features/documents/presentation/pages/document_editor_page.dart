import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/models/grouping_model.dart';
import 'package:myfinances/src/core/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';

import '../views/document_details_bottom_sheet_modal.dart';

class DocumentEditorPage extends GetWidget<DocumentEditorController> {
  const DocumentEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(controller.documentModel.name),
        leading: _closeButton(context),
        actions: [
          _documentInfoMenuButton(context),
        ],
      ),
      body: Column(
        children: [
          GroupingWidget(
            groupingModel: GroupingModel(
              title: 'testando primeiro',
              initializeExpanded: false,
              creationDate: DateTime.now(),
            ),
            items: const [],
          ),
          GroupingWidget(
            groupingModel: GroupingModel(
              title: 'testando segundo',
              initializeExpanded: false,
              creationDate: DateTime.now(),
            ),
            items: const [],
          ),
          GroupingWidget(
            groupingModel: GroupingModel(
              title: 'testando terceiro',
              initializeExpanded: true,
              creationDate: DateTime.now(),
            ),
            items: const [],
          ),
        ],
      ),
    );
  }

  Widget _documentInfoMenuButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return DocumentDetailsBottomSheetModalWidget(
              documentModel: controller.documentModel,
            );
          },
        );
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget _closeButton(BuildContext context) {
    return IconButton(
      tooltip: 'close-button'.i18n(),
      onPressed: () {
        //TODO: Mostrar dialogo de confirmação.
        Get.close(1);
      },
      icon: const Icon(Icons.close),
    );
  }
}
