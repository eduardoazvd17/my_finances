import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinances/src/core/data/utils/date_time_utils.dart';
import 'package:myfinances/src/features/documents_page/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents_page/data/models/document_model.dart';

class DocumentTileWidget extends StatelessWidget {
  final DocumentModel documentModel;
  const DocumentTileWidget({
    super.key,
    required this.documentModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
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
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
