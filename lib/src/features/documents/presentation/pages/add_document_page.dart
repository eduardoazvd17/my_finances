import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../controllers/documents_controller.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../../../core/presentation/widgets/drop_down_button_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../data/enums/document_type.dart';

class AddDocumentPage extends GetWidget<DocumentsController> {
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('add-document-button'.i18n()),
      ),
      body: ScrollViewWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              label: 'add-document-name-label'.i18n(),
              hint: 'add-document-name-hint'.i18n(),
              controller: controller.nameController,
              focusNode: controller.nameFocus,
              textCapitalization: TextCapitalization.sentences,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => controller.typeFocus.requestFocus(),
            ),
            Text('add-document-type-label'.i18n()),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: DropDownButtonWidget<DocumentType?>(
                      itemHeight: 70,
                      isExpanded: true,
                      focusNode: controller.typeFocus,
                      value: controller.selectedDocumentType,
                      onChanged: (value) {
                        controller.selectedDocumentType = value;
                      },
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'add-document-type-label'.i18n(),
                                style: const TextStyle(
                                  color: AppThemes.commonColor,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                        ...DocumentType.values.map((documentType) {
                          return DropdownMenuItem(
                            value: documentType,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.5,
                                      right: 5.0,
                                    ),
                                    child: Icon(documentType.icon, size: 40),
                                  ),
                                  Expanded(
                                    child:
                                        Text(documentType.title, maxLines: 2),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Text(
                controller.selectedDocumentType?.description ?? '',
                textAlign: TextAlign.left,
                style: const TextStyle(color: AppThemes.commonColor),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      icon: CupertinoIcons.add,
                      text: 'add-button'.i18n(),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      onTap: controller.createNewDocument,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
