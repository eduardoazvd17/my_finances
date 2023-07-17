import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/advise_message_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/floating_bottom_menu_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/features/documents/presentation/views/new_item_bottom_sheet_modal.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_tile_widget.dart';

import '../views/document_details_bottom_sheet_modal.dart';
import '../views/add_or_edit_group_bottom_sheet_modal.dart';

class DocumentEditorPage extends GetWidget<DocumentEditorController> {
  const DocumentEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ScaffoldWidget(
        appBar: AppBar(
          title: Text(controller.documentModel.name),
          leading: _closeButton(context),
          actions: [
            _documentInfoMenuButton(context),
          ],
        ),
        floatingBottomMenu: _floatingBottomMenu(context),
        body: Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: LoadingWidget(removeLogo: true, text: ''),
            );
          } else if (controller.groups.isEmpty &&
              controller.itemsWithoutGroup.isEmpty) {
            return _emptyDataContent();
          } else {
            return _dataListContent();
          }
        }),
      ),
    );
  }

  Widget _emptyDataContent() {
    return Center(
      child: AdviseMessageWidget(
        icon: Icons.info_outline,
        message: 'editor-data-empty-title-text'.i18n(),
        description: 'editor-data-empty-description-text'.i18n(),
      ),
    );
  }

  Widget _dataListContent() {
    return Column(
      children: [
        ...controller.groups.map((groupingModel) {
          return GroupingWidget(
            documentType: controller.documentModel.type,
            groupingModel: groupingModel,
            isSelected: controller.selectedGroup == groupingModel,
            onSelect: () {
              if (controller.selectedGroup == groupingModel) {
                controller.selectedGroup = null;
              } else {
                controller.selectedGroup = groupingModel;
              }
            },
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
    );
  }

  Widget _documentInfoMenuButton(BuildContext context) {
    return IconButton(
      tooltip: 'document-info-button'.i18n(),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          barrierColor: Colors.black87,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) {
            return DocumentDetailsBottomSheetModalWidget(
              documentModel: controller.documentModel,
            );
          },
        );
      },
      icon: const Icon(Icons.info_outline),
    );
  }

  Widget _closeButton(BuildContext context) {
    return IconButton(
      tooltip: 'close-button'.i18n(),
      onPressed: () {
        Get.close(1);
      },
      icon: const Icon(Icons.close),
    );
  }

  Widget _floatingBottomMenu(BuildContext context) {
    final scrollController = ScrollController(
      initialScrollOffset: controller.menuScrollPosition,
    );

    scrollController.addListener(() {
      controller.menuScrollPosition = scrollController.offset;
    });

    return Obx(
      () => FloatingBottomMenuWidget(
        selectedName: controller.selectedGroup?.name,
        onRemoveSelected: () => controller.selectedGroup = null,
        scrollController: scrollController,
        items: [
          if (controller.selectedGroup == null)
            FloatingBottomMenuItem(
              icon: Icons.post_add_rounded,
              tooltip: 'new-group-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditGroupBottomSheetModal(
                      controller: controller,
                    );
                  },
                );
              },
            ),
          FloatingBottomMenuItem(
            icon: Icons.format_list_bulleted_add,
            tooltip: 'new-item-button'.i18n(),
            showTooltip: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.black87,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) {
                  return const NewItemBottomSheetModal();
                },
              );
            },
          ),
          if (controller.selectedGroup != null) ...[
            FloatingBottomMenuItem(
              icon: Icons.edit_note,
              tooltip: 'edit-group-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditGroupBottomSheetModal(
                      controller: controller,
                      groupingModel: controller.selectedGroup,
                    );
                  },
                );
              },
            ),
            FloatingBottomMenuItem(
              icon: Icons.close,
              tooltip: 'delete-group-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditGroupBottomSheetModal(
                      controller: controller,
                      groupingModel: controller.selectedGroup,
                    );
                  },
                );
              },
            ),
          ],
          FloatingBottomMenuItem(
            icon: Icons.info_outline,
            tooltip: 'document-info-button'.i18n(),
            showTooltip: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.black87,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) {
                  return DocumentDetailsBottomSheetModalWidget(
                    documentModel: controller.documentModel,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
