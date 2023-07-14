import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/custom_dialog.dart';
import 'package:myfinances/src/core/presentation/widgets/text_field_widget.dart';
import 'package:myfinances/src/features/documents/data/models/document_model.dart';

import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../widgets/document_details_widget.dart';

class DocumentDetailsBottomSheetModalWidget extends StatefulWidget {
  final DocumentModel documentModel;
  final Future<bool> Function({
    required DocumentModel documentModel,
    bool? newIsFavorite,
    String? newName,
  })? onEdit;
  final Function(DocumentModel)? onDelete;

  const DocumentDetailsBottomSheetModalWidget({
    super.key,
    required this.documentModel,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<DocumentDetailsBottomSheetModalWidget> createState() =>
      _DocumentDetailsBottomSheetModalWidgetState();
}

class _DocumentDetailsBottomSheetModalWidgetState
    extends State<DocumentDetailsBottomSheetModalWidget> {
  bool? _isFavorite;

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DocumentDetailsWidget(documentModel: widget.documentModel),
            if (widget.onEdit != null) ...[
              const Divider(),
              _favoriteButton(context),
              const Divider(),
              _renameButton(context),
              const Divider(),
            ],
            if (widget.onDelete != null) _deleteButton(context),
            if (widget.onDelete == null && widget.onEdit == null)
              const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            icon: Icon(
              _isFavorite ?? widget.documentModel.isFavorite
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
              color: Colors.red[300],
            ),
            text: _isFavorite ?? widget.documentModel.isFavorite
                ? 'remove-from-favorite-button'.i18n()
                : 'add-to-favorite-button'.i18n(),
            borderColor: Colors.transparent,
            foregroundColor: Colors.red[300],
            onTap: () {
              setState(() {
                if (_isFavorite == null) {
                  _isFavorite = !widget.documentModel.isFavorite;
                } else {
                  _isFavorite = !(_isFavorite!);
                }
              });
              widget.onEdit?.call(
                documentModel: widget.documentModel,
                newIsFavorite: _isFavorite,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _renameButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            icon: Icon(
              CupertinoIcons.pencil,
              color: Theme.of(context).primaryColor,
            ),
            borderColor: Colors.transparent,
            text: 'rename-button'.i18n(),
            onTap: () {
              final nameController = TextEditingController(
                text: widget.documentModel.name,
              );

              Future<void> onConfirm() async {
                final bool? result = await widget.onEdit?.call(
                  documentModel: widget.documentModel,
                  newName: nameController.text,
                );
                if (result == true) Get.close(1);
              }

              Get.close(1);
              Get.dialog(
                CustomDialog(
                  autoClose: false,
                  title: 'rename-document-dialog-title'.i18n(),
                  confirmButtonText: 'rename-button'.i18n(),
                  onConfirm: onConfirm,
                  closeButtonText: 'cancel-button'.i18n(),
                  onClose: () => Get.close(1),
                  child: TextFieldWidget(
                    autofocus: true,
                    label: 'rename-document-label'.i18n(),
                    hint: 'rename-document-hint'.i18n(),
                    controller: nameController,
                    focusNode: FocusNode(),
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => onConfirm(),
                  ),
                ),
                barrierDismissible: false,
                barrierColor: Colors.black87,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _deleteButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            icon: const Icon(CupertinoIcons.trash, color: Colors.red),
            text: 'delete-button'.i18n(),
            foregroundColor: Colors.red,
            borderColor: Colors.transparent,
            onTap: () {
              Get.dialog(
                CustomDialog(
                  title: 'delete-document-dialog-title'.i18n(),
                  content: 'delete-document-confirmation-text'.i18n(),
                  invertButtonColor: true,
                  onConfirm: () async {
                    Get.close(1);
                    widget.onDelete?.call(widget.documentModel);
                  },
                ),
                barrierColor: Colors.black87,
              );
            },
          ),
        ),
      ],
    );
  }
}
