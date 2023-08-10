import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/floating_bottom_menu_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/features/documents/presentation/views/add_or_edit_item_bottom_sheet_modal.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/annotation_item_total_tile.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/grouping_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/investiment_item_total_tile.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_widget.dart';

import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../../data/enums/document_type.dart';
import '../../data/enums/operation_type.dart';
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
          leading: IconButton(
            tooltip: 'close-button'.i18n(),
            onPressed: () {
              Get.close(1);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            _getDocumentInfoMenuButton(context),
          ],
        ),
        floatingBottomMenu: _getDocumentFloatingMenu(context),
        body: Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: LoadingWidget(removeLogo: true, text: ''),
            );
          } else if (controller.groups.isEmpty &&
              controller.itemsWithoutGroup.isEmpty) {
            return Center(
              child: controller.documentModel.type.emptyDocumentAdviseWidget,
            );
          } else {
            return _getDocumentContent();
          }
        }),
      ),
    );
  }

  Widget _getDocumentContent() {
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
            const SizedBox(height: 125),
          ],
        ),
      ),
    );
  }

  Widget _getDocumentInfoMenuButton(BuildContext context) {
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
              additionalContent: _getInfoAdditionalContentByDocumentType(),
            );
          },
        );
      },
      icon: const Icon(Icons.info_outline),
    );
  }

  Widget _getDocumentFloatingMenu(BuildContext context) {
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
        items: _getDocumentFloatingMenuItems(context),
      ),
    );
  }

  List<FloatingBottomMenuItem> _getDocumentFloatingMenuItems(
    BuildContext context,
  ) {
    //TODO: Menu para cada tipo de ItemModel.
    return switch (controller.documentModel.type) {
      DocumentType.monthlyExpenseControl => [],
      DocumentType.investmentControl => [
          if (controller.selectedGroup == null &&
              controller.selectedItem == null) ...[
            FloatingBottomMenuItem(
              icon: Icons.post_add_rounded,
              tooltip: 'add-asset-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditGroupBottomSheetModal(
                      icon: Icons.post_add_rounded,
                      title: 'add-asset-button'.i18n(),
                      controller: controller,
                    );
                  },
                );
              },
            ),
          ],
          if (controller.selectedGroup != null) ...[
            FloatingBottomMenuItem(
              icon: Icons.add,
              tooltip: 'add-asset-operation-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditItemBottomSheetModal(
                      icon: Icons.add,
                      title: 'add-asset-operation-button'.i18n(),
                      controller: controller,
                      groupingModel: controller.selectedGroup,
                    );
                  },
                );
              },
            ),
            FloatingBottomMenuItem(
              icon: CupertinoIcons.pencil,
              tooltip: 'edit-asset-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditGroupBottomSheetModal(
                      icon: CupertinoIcons.pencil,
                      title: 'edit-asset-button'.i18n(),
                      groupingModel: controller.selectedGroup,
                      controller: controller,
                    );
                  },
                );
              },
            ),
            FloatingBottomMenuItem(
              icon: CupertinoIcons.delete,
              tooltip: 'delete-asset-button'.i18n(),
              foregroundColor: Colors.red,
              showTooltip: true,
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'delete-asset-button'.i18n(),
                    content: 'delete-asset-confirmation-text'.i18n(),
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
            FloatingBottomMenuItem(
              icon: CupertinoIcons.pencil,
              tooltip: 'edit-asset-operation-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.black87,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditItemBottomSheetModal(
                      icon: CupertinoIcons.pencil,
                      title: 'edit-asset-operation-button'.i18n(),
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
              tooltip: 'delete-asset-operation-button'.i18n(),
              foregroundColor: Colors.red,
              showTooltip: true,
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'delete-asset-operation-button'.i18n(),
                    content: 'delete-asset-operation-confirmation-text'.i18n(),
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
      DocumentType.annotation => [
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
                      icon: Icons.post_add_rounded,
                      title: 'new-group-button'.i18n(),
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
                      icon: Icons.format_list_bulleted_add,
                      title: 'new-item-button'.i18n(),
                      controller: controller,
                      groupingModel: controller.selectedGroup,
                    );
                  },
                );
              },
            ),
          if (controller.selectedItem == null &&
              controller.documentModel.type == DocumentType.annotation &&
              controller.items.cast<AnnotationItemModel>().where((e) {
                    if (controller.selectedGroup != null) {
                      return e.isChecked &&
                          controller.selectedGroup!.id == e.groupingId;
                    } else {
                      return e.isChecked;
                    }
                  }).length >=
                  2)
            FloatingBottomMenuItem(
              icon: Icons.check_box,
              tooltip: 'uncheck-all-items-button'.i18n(),
              showTooltip: true,
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'uncheck-all-items-button'.i18n(),
                    content: controller.selectedGroup != null
                        ? 'uncheck-all-group-confirmation-text'.i18n()
                        : 'uncheck-all-confirmation-text'.i18n(),
                    invertButtonColor: true,
                    onConfirm: () {
                      controller.uncheckAllAnnotationItems(
                        controller.selectedGroup?.id,
                      );
                    },
                  ),
                  barrierColor: Colors.black87,
                );
              },
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
                      icon: CupertinoIcons.pencil,
                      title: 'edit-group-button'.i18n(),
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
                      icon: CupertinoIcons.pencil,
                      title: 'edit-item-button'.i18n(),
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
      DocumentType.pointsAndAirlineMiles => [],
    };
  }

  Widget _getInfoAdditionalContentByDocumentType() {
    const styleLabel = TextStyle(fontWeight: FontWeight.bold);

    //TODO: Totalização de dados para cada tipo de DocumentType.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: switch (controller.documentModel.type) {
        DocumentType.monthlyExpenseControl => [],
        DocumentType.investmentControl => [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Center(
                child: Text('resume-text'.i18n(), style: styleLabel),
              ),
            ),
            ...controller.groups.map((g) {
              final itemsByGroup = controller
                  .getItemsByGroup(g.id)
                  .cast<InvestimentControlItemModel>();

              if (itemsByGroup.isEmpty) {
                return Container();
              } else {
                final purchasesItems = itemsByGroup.where((i) {
                  return i.operationType == OperationType.buy;
                });

                final salesItems = itemsByGroup.where((i) {
                  return i.operationType == OperationType.sell;
                });

                return InvestimentItemTotalTile(
                  title: g.name,
                  purchasesValue: purchasesItems.isEmpty
                      ? 0
                      : purchasesItems
                          .map((i) => i.quantity * i.price)
                          .reduce((a, b) => a + b),
                  purchasesQuotas: purchasesItems.isEmpty
                      ? 0
                      : purchasesItems
                          .map((i) => i.quantity)
                          .reduce((a, b) => a + b),
                  salesValue: salesItems.isEmpty
                      ? 0
                      : salesItems
                          .map((i) => i.quantity * i.price)
                          .reduce((a, b) => a + b),
                  salesQuotas: salesItems.isEmpty
                      ? 0
                      : salesItems
                          .map((i) => i.quantity)
                          .reduce((a, b) => a + b),
                  quotasValue: purchasesItems.isEmpty && salesItems.isEmpty
                      ? 0
                      : itemsByGroup
                          .map((e) => switch (e.operationType) {
                                OperationType.buy => e.quantity * e.price,
                                OperationType.sell => -(e.quantity * e.price),
                              })
                          .reduce((a, b) => a + b),
                  quotas: purchasesItems.isEmpty && salesItems.isEmpty
                      ? 0
                      : itemsByGroup
                          .map((e) => switch (e.operationType) {
                                OperationType.buy => e.quantity,
                                OperationType.sell => -e.quantity,
                              })
                          .reduce((a, b) => a + b),
                );
              }
            }),
          ],
        DocumentType.annotation => [
            const Divider(),
            AnnotationItemTotalTile(
              title: 'total-label'.i18n(),
              price: controller.items.isEmpty
                  ? 0
                  : controller.items
                      .cast<AnnotationItemModel>()
                      .map((i) {
                        return (i.quantity ?? 1) * (i.price ?? 0);
                      })
                      .reduce((a, b) => a + b)
                      .toDouble(),
              quantity: controller.items.length,
            ),
            const Divider(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'total-by-grouping-text'.i18n(),
                  style: styleLabel,
                ),
              ),
            ),
            ...controller.groups.map(
              (g) {
                final itemsByGroup = controller
                    .getItemsByGroup(g.id)
                    .cast<AnnotationItemModel>();

                if (itemsByGroup.isEmpty) {
                  return Container();
                } else {
                  final Iterable<double> itemsPrice = itemsByGroup.map((i) {
                    return (i.quantity ?? 1) * (i.price ?? 0);
                  });

                  return AnnotationItemTotalTile(
                    title: g.name,
                    price: itemsPrice.isEmpty
                        ? 0
                        : itemsPrice.reduce((a, b) => a + b).toDouble(),
                    quantity: itemsByGroup.length,
                  );
                }
              },
            ),
            if (controller.itemsWithoutGroup.isNotEmpty)
              AnnotationItemTotalTile(
                title: 'items-without-group'.i18n([
                  controller.itemsWithoutGroup.length.toString(),
                ]),
                price: controller.itemsWithoutGroup
                    .cast<AnnotationItemModel>()
                    .map((e) => e.price ?? 0)
                    .reduce((a, b) => a + b)
                    .toDouble(),
                quantity: null,
              ),
          ],
        DocumentType.pointsAndAirlineMiles => [],
      },
    );
  }
}
