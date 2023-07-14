import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/views/settings_bottom_sheet_modal.dart';
import 'package:myfinances/src/core/presentation/widgets/advise_message_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/floating_bottom_menu_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/list_header_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/document_tile_widget.dart';

import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../controllers/documents_controller.dart';
import '../views/documents_order_bottom_sheet_modal.dart';

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
      floatingBottomMenu: _addDocumentFloatingButton(context),
      body: ListHeaderWidget(
        title: 'my-documents-text'.i18n(),
        expandedContent: true,
        action: _orderDocumentsButton(context),
        content: Obx(() {
          if (controller.userDocuments.isEmpty) {
            return _emptyDocumentsContent();
          } else {
            return _documentsListWidget();
          }
        }),
      ),
    );
  }

  Widget _emptyDocumentsContent() {
    return Center(
      child: AdviseMessageWidget(
        icon: Icons.info_outline,
        message: 'my-documents-empty-title-text'.i18n(),
        description: 'my-documents-empty-description-text'.i18n(),
      ),
    );
  }

  Widget _documentsListWidget() {
    final scrollController = ScrollController(
      initialScrollOffset: controller.documentsScrollPosition,
    );

    scrollController.addListener(() {
      controller.documentsScrollPosition = scrollController.offset;
    });

    return ScrollViewWidget(
      showBar: true,
      controller: scrollController,
      child: Column(
        children: controller.userDocuments.map((documentModel) {
          final int index = controller.userDocuments.indexOf(documentModel);

          final bool showFavoriteHeader =
              index == 0 && documentModel.isFavorite;

          final bool showAllHeader = index > 0 &&
              controller.userDocuments[index - 1].isFavorite &&
              !documentModel.isFavorite;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showFavoriteHeader)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'favorites-documents-text'.i18n(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              if (showAllHeader)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'all-documents-text'.i18n(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              DocumentTileWidget(
                documentModel: documentModel,
                onTap: controller.openDocument,
                onEdit: controller.editDocument,
                onDelete: controller.deleteDocument,
              ),
              if (index == controller.userDocuments.length - 1)
                const SizedBox(height: 65),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.settings),
      onPressed: () => showModalBottomSheet(
        context: context,
        barrierColor: Colors.black87,
        useSafeArea: true,
        builder: (_) => const SettingsBottomSheetModal(),
      ),
    );
  }

  Widget _addDocumentFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(15),
        child: FloatingBottomMenuItem(
          icon: Icons.add,
          onTap: controller.goToAddDocumentPage,
          tooltip: 'add-document-button'.i18n(),
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          showTooltip: true,
        ),
      ),
    );
  }

  Widget _orderDocumentsButton(BuildContext context) {
    return IconButtonWidget(
      tooltip: 'order-document-button'.i18n(),
      onTap: () {
        showModalBottomSheet(
          context: context,
          barrierColor: Colors.black87,
          useSafeArea: true,
          builder: (_) => const DocumentsOrderBottomSheetModal(),
        );
      },
      icon: Icons.filter_list,
      backgroundColor: Colors.transparent,
    );
  }
}
