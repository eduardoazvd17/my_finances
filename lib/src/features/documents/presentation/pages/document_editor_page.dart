import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/presentation/widgets/expandable_grouping_widget.dart';
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
        actions: [
          _documentInfoMenuButton(context),
        ],
      ),
      body: ExpandableGroupingWidget(
        icon: Icons.ac_unit,
        title: 'Aqui vai ficar o título',
        subtitle: 'descrição vai ficar aqui...',
        child: const Text('gasto 1\ngasto 2\ngasto 3\ngasto 4\ngasto 5'),
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
}
