import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/views/settings_bottom_sheet_modal.dart';
import 'package:myfinances/src/core/presentation/widgets/advise_message_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/icon_button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';
import 'package:myfinances/src/features/documents_page/presentation/widgets/document_tile_widget.dart';

import '../controllers/documents_controller.dart';

class DocumentsPage extends GetWidget<DocumentsController> {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: AppLogo(size: 35),
        centerTitle: false,
        actions: [
          _settingsMenuButton(context),
        ],
      ),
      body: GroupingWidget(
        title: 'my-documents-text'.i18n(),
        expandedContent: true,
        action: IconButtonWidget(
          tooltip: 'add-document-button'.i18n(),
          onTap: controller.goToAddDocumentPage,
          icon: CupertinoIcons.add,
        ),
        content: Obx(() {
          if (controller.userDocuments.isEmpty) {
            return Center(
              child: AdviseMessageWidget(
                icon: Icons.info_outline,
                message: 'my-documents-empty-title-text'.i18n(),
                description: 'my-documents-empty-description-text'.i18n(),
                actionButtonText: 'add-document-button'.i18n(),
                actionButtonIcon: CupertinoIcons.add,
                onAction: controller.goToAddDocumentPage,
              ),
            );
          } else {
            return ScrollViewWidget(
              child: Column(
                children: controller.userDocuments.map((documentModel) {
                  return DocumentTileWidget(
                    documentModel: documentModel,
                    onTap: () => controller.openDocument(documentModel),
                  );
                }).toList(),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.settings),
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => const SettingsBottomSheetModal(),
      ),
    );
  }
}
