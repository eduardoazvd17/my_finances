import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinances/src/core/data/utils/date_time_utils.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';

import '../views/edit_document_bottom_sheet_modal.dart';

class DocumentTileWidget extends StatelessWidget {
  final DocumentModel documentModel;
  final void Function(DocumentModel) onTap;
  final Future<bool> Function({
    required DocumentModel documentModel,
    bool? newIsFavorite,
    String? newName,
  }) onEdit;
  final void Function(DocumentModel) onDelete;
  const DocumentTileWidget({
    super.key,
    required this.documentModel,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: InkWell(
        onTap: () => onTap(documentModel),
        onLongPress: () => _openMenu(context),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(documentModel.type.icon, size: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(documentModel.name, maxLines: 2),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          CupertinoIcons.pencil,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        DateTimeUtils.formatFullDateByLocale(
                          documentModel.lastEditDate,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _openMenu(context),
            )
          ],
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditDocumentBottomSheetModalWidget(
            documentModel: documentModel,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}
