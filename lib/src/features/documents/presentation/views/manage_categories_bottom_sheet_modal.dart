import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/widgets/advise_message_widget.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../controllers/document_editor_controller.dart';
import 'add_or_edit_group_bottom_sheet_modal.dart';

class ManageCategoriesBottomSheetModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  const ManageCategoriesBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: icon,
      title: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('created-categories-label'.i18n()),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _createdCategoriesListWidget(context),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ButtonWidget(
                icon: Icons.post_add_rounded,
                text: 'add-category-button'.i18n(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) {
                      return AddOrEditGroupBottomSheetModal(
                        icon: Icons.post_add_rounded,
                        title: 'add-category-button'.i18n(),
                        controller: controller,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createdCategoriesListWidget(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Obx(
        () {
          if (controller.groups.isEmpty) {
            return Center(
              child: AdviseMessageWidget(
                icon: icon,
                message: 'empty-categories-title'.i18n(),
                description: 'empty-categories-description'.i18n(),
              ),
            );
          }

          return ListView(
            children: controller.groups.map(
              (group) {
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (context) {
                              return AddOrEditGroupBottomSheetModal(
                                icon: CupertinoIcons.pencil,
                                title: 'edit-category-button'.i18n(),
                                controller: controller,
                                groupingModel: group,
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(group.name),
                              Row(
                                children: [
                                  const SizedBox(width: 5),
                                  if (group.initializeExpanded) ...[
                                    IconButtonWidget(
                                      iconSize: 21,
                                      tooltip: 'start-expanded'.i18n(),
                                      icon: CupertinoIcons
                                          .rectangle_expand_vertical,
                                      iconColor: AppThemes.commonColor,
                                      compactMode: true,
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                  const Icon(CupertinoIcons.pencil),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButtonWidget(
                      tooltip: 'delete-category-button'.i18n(),
                      icon: Icons.close,
                      iconColor: Colors.red,
                      compactMode: true,
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                            title: 'delete-category-button'.i18n(),
                            content: 'delete-category-confirmation-text'.i18n(),
                            invertButtonColor: true,
                            onConfirm: () {
                              controller.deleteGroup(group);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
