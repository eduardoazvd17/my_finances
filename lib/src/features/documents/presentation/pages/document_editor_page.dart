import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/advise_message_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/floating_bottom_menu_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/features/documents/presentation/views/add_or_edit_item_bottom_sheet_modal.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_widget.dart';

import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../../data/enums/document_type.dart';
import '../../data/models/item_model.dart';
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
    return Obx(
      () => ScrollViewWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...controller.groups.map((groupingModel) {
              return GroupingWidget(groupingModel: groupingModel);
            }),
            ...controller.itemsWithoutGroup.map((itemModel) {
              return ItemWidget(itemModel: itemModel);
            }),
            const SizedBox(height: 140),
          ],
        ),
      ),
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
        selectedName:
            controller.selectedItem?.name ?? controller.selectedGroup?.name,
        onRemoveSelected: () {
          controller.selectedItem = null;
          controller.selectedGroup = null;
        },
        scrollController: scrollController,
        items: [
          if (controller.selectedGroup == null &&
              controller.selectedItem == null)
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
          if (controller.selectedItem == null)
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
                    return AddOrEditItemBottomSheetModal(
                      controller: controller,
                      groupingModel: controller.selectedGroup,
                    );
                  },
                );
              },
            ),
          if (controller.selectedItem == null &&
              controller.documentModel.type == DocumentType.annotation &&
              controller.items
                      .cast<AnnotationItemModel>()
                      .where((e) => e.isChecked)
                      .length >=
                  2)
            FloatingBottomMenuItem(
              icon: Icons.check_box,
              tooltip: 'uncheck-all-items-button'.i18n(),
              showTooltip: true,
              onTap: () => controller.uncheckAllAnnotationItems(
                controller.selectedGroup?.id,
              ),
            ),
          if (controller.selectedGroup != null) ...[
            FloatingBottomMenuItem(
              icon: CupertinoIcons.pencil,
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
                      groupingModel: controller.selectedGroup!,
                    );
                  },
                );
              },
            ),
            FloatingBottomMenuItem(
              icon: CupertinoIcons.delete,
              tooltip: 'delete-group-button'.i18n(),
              foregroundColor: Colors.red,
              showTooltip: true,
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'delete-group-button'.i18n(),
                    content: 'delete-group-confirmation-text'.i18n(),
                    invertButtonColor: true,
                    onConfirm: () {
                      controller.deleteGroup(controller.selectedGroup!);
                    },
                  ),
                  barrierColor: Colors.black87,
                );
              },
            ),
          ],
          if (controller.selectedItem != null) ...[
            if (controller.documentModel.type == DocumentType.annotation)
              FloatingBottomMenuItem(
                icon: (controller.selectedItem as AnnotationItemModel).isChecked
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                tooltip:
                    (controller.selectedItem as AnnotationItemModel).isChecked
                        ? 'uncheck-item-button'.i18n()
                        : 'check-item-button'.i18n(),
                showTooltip: true,
                onTap: () => controller.toggleIsCheckedAnnotationItem(
                  controller.selectedItem as AnnotationItemModel,
                ),
              ),
            FloatingBottomMenuItem(
              icon: CupertinoIcons.pencil,
              tooltip: 'edit-item-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditItemBottomSheetModal(
                      controller: controller,
                      groupingModel: controller.groups.firstWhereOrNull(
                        (e) => e.id == controller.selectedItem!.groupingId,
                      ),
                      itemModel: controller.selectedItem,
                    );
                  },
                );
              },
            ),
            FloatingBottomMenuItem(
              icon: CupertinoIcons.delete,
              tooltip: 'delete-item-button'.i18n(),
              foregroundColor: Colors.red,
              showTooltip: true,
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'delete-item-button'.i18n(),
                    content: 'delete-item-confirmation-text'.i18n(),
                    invertButtonColor: true,
                    onConfirm: () {
                      controller.deleteItem(controller.selectedItem!);
                    },
                  ),
                  barrierColor: Colors.black87,
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
