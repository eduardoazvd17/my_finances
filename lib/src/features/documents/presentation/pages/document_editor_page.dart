import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_tile_widget.dart';

import '../../data/models/grouping_model.dart';
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
          ...controller.groups.map((groupingModel) {
            return GroupingWidget(
              groupingModel: groupingModel,
              documentType: controller.documentModel.type,
              items: controller.getItemsByGroup(groupingModel.id),
            );
          }),
          ...controller.itemsWithoutGroup.map(
            (itemModel) => ItemTileWidget(
              item: itemModel,
              documentType: controller.documentModel.type,
            ),
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
