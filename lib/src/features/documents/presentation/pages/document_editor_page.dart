import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_picker.dart';
import '../../../../core/presentation/widgets/floating_bottom_menu_widget.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../../../../core/presentation/widgets/list_header_widget.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../data/enums/month_enum.dart';
import '../views/add_or_edit_item_bottom_sheet_modal.dart';
import '../views/manage_categories_bottom_sheet_modal.dart';
import '../widgets/annotation_total_content.dart';
import '../widgets/balance_widget.dart';
import '../widgets/investiment_control_total_content.dart';
import '../widgets/grouping_widget.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';
import '../controllers/document_editor_controller.dart';
import '../widgets/item_widget.dart';

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
          leading: IconButtonWidget(
            tooltip: 'close-button'.i18n(),
            onTap: Get.back,
            icon: Icons.close,
          ),
          actions: [
            _getDocumentInfoMenuButton(context),
          ],
        ),
        floatingBottomMenu: _getDocumentFloatingMenu(context),
        body: Column(
          children: [
            if (controller.isMonthlyExpensesControl)
              Obx(() => _monthlyExpenseControlHeaderWidget(context)),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: LoadingWidget());
                } else if (controller.groups.isEmpty &&
                    controller.itemsWithoutGroup.isEmpty) {
                  return Center(
                    child:
                        controller.documentModel.type.emptyDocumentAdviseWidget,
                  );
                } else {
                  return _getDocumentContent(context);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDocumentContent(BuildContext context) {
    final ScrollController scrollController = ScrollController(
      initialScrollOffset: controller.pageScrollPosition,
    );

    scrollController.addListener(() {
      controller.pageScrollPosition = scrollController.offset;
    });

    if (controller.documentModel.type == DocumentType.monthlyExpenseControl &&
        controller.items.isEmpty) {
      return Center(
        child: controller.documentModel.type.emptyDocumentAdviseWidget,
      );
    }

    return ScrollViewWidget(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.documentModel.type ==
              DocumentType.monthlyExpenseControl) ...[
            Text('Mostrar gastos aqui.'),
          ] else ...[
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.groups.map((groupingModel) {
                  return GroupingWidget(
                    groupingModel: groupingModel,
                    documentEditorController: controller,
                  );
                }).toList(),
              ),
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.itemsWithoutGroup.map((itemModel) {
                  return ItemWidget(
                    itemModel: itemModel,
                    documentEditorController: controller,
                  );
                }).toList(),
              ),
            ),
          ],
          const SizedBox(height: 125),
        ],
      ),
    ).animate().fade();
  }

  Widget _getDocumentInfoMenuButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButtonWidget(
        tooltip: 'document-info-button'.i18n(),
        icon: Icons.info_outline,
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) {
              return DocumentDetailsBottomSheetModalWidget(
                documentModel: controller.documentModel,
                additionalContent:
                    _getInfoAdditionalContentByDocumentType(context),
              );
            },
          );
        },
      ),
    );
  }

  Widget _getInfoAdditionalContentByDocumentType(BuildContext context) {
    if (controller.items.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text('empty-document-total-text'.i18n()),
          ),
        ],
      );
    }

    //TODO: Totalização de dados para cada tipo de DocumentType.
    return switch (controller.documentModel.type) {
      DocumentType.monthlyExpenseControl => Container(),
      DocumentType.investmentControl => InvestimentControlTotalContent(
          groups: controller.groups,
          items: controller.items.cast<InvestimentControlItemModel>(),
        ),
      DocumentType.annotation => AnnotationTotalContent(
          groups: controller.groups,
          items: controller.items.cast<AnnotationItemModel>(),
        ),
      //DocumentType.pointsAndAirlineMiles => Container(),
    };
  }

  Widget _monthlyExpenseControlHeaderWidget(BuildContext context) {
    if (!controller.isMonthlyExpensesControl) return Container();

    return ListHeaderWidget(
      title: controller.selectedMonth.title,
      subtitleContent: BalanceWidget(
        earnings: controller.selectedMonthEarnings,
        expenses: controller.selectedMonthExpenses,
        balance: controller.selectedMonthBalance,
      ),
      action: IconButtonWidget(
        key: key,
        icon: CupertinoIcons.calendar_today,
        tooltip: 'change-month-button'.i18n(),
        compactMode: true,
        onTap: () {
          if (!kIsWeb) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) {
                return BottomSheetModalPicker(
                  icon: CupertinoIcons.calendar_today,
                  title: 'change-month-button'.i18n(),
                  itemsWidget: MonthEnum.values.map((e) => Text(e.title)),
                  selectedIndex: controller.selectedMonth.index,
                  onChange: (int index) {
                    controller.selectedMonth = MonthEnum.values[index];
                  },
                );
              },
            );
          } else {
            const double maxDesktopWidth = ResponsiveBuilder.maxDesktopWidth;
            final double screenWidth = Get.width;
            final double diff = screenWidth - maxDesktopWidth;
            final bool reducePaddingTop =
                screenWidth < ResponsiveBuilder.maxMobileWidth;
            final RelativeRect position = RelativeRect.fromLTRB(
              ResponsiveBuilder.maxDesktopWidth,
              reducePaddingTop ? 110 : 185.0,
              (diff / 2) + 14,
              0,
            );

            showMenu(
              context: context,
              position: position,
              items: MonthEnum.values.map(
                (e) {
                  return PopupMenuItem<MonthEnum>(
                    value: e,
                    child: Text(e.title),
                    onTap: () {
                      controller.selectedMonth = e;
                    },
                  );
                },
              ).toList(),
            );
          }
        },
      ),
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
      DocumentType.monthlyExpenseControl => [
          if (controller.groups.isNotEmpty)
            FloatingBottomMenuItem(
              icon: Icons.post_add_rounded,
              tooltip: 'new-value-button'.i18n(),
              showTooltip: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return AddOrEditItemBottomSheetModal(
                      icon: Icons.post_add_rounded,
                      title: 'new-value-button'.i18n(),
                      controller: controller,
                    );
                  },
                );
              },
            ),
          FloatingBottomMenuItem(
            icon: Icons.list_alt_rounded,
            tooltip: 'manage-categories-button'.i18n(),
            showTooltip: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) {
                  return ManageCategoriesBottomSheetModal(
                    icon: Icons.list_alt_rounded,
                    title: 'manage-categories-button'.i18n(),
                    controller: controller,
                  );
                },
              );
            },
          ),
        ],
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
                );
              },
            ),
          ],
        ],
      //DocumentType.pointsAndAirlineMiles => [],
    };
  }
}

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
