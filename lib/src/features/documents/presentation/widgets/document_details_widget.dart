import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/documents/data/enums/document_type.dart';

import '../../../../core/data/utils/date_time_utils.dart';
import '../../data/models/document_model.dart';

class DocumentDetailsWidget extends StatelessWidget {
  final DocumentModel documentModel;
  const DocumentDetailsWidget({super.key, required this.documentModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Icon(documentModel.type.icon, size: 40),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                documentModel.name,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              )),
            ],
          ),
        ),
        const Divider(),
        _textTile(
            label: 'document-type-label'.i18n(),
            data: documentModel.type.title),
        _textTile(
          label: 'document-creation-date-label'.i18n(),
          data: DateTimeUtils.formatFullDate(
            documentModel.creationDate,
          ),
        ),
        _textTile(
          label: 'document-last-modification-date-label'.i18n(),
          data: DateTimeUtils.formatFullDate(
            documentModel.lastEditDate,
          ),
        ),
      ],
    );
  }

  Widget _textTile({required String label, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Wrap(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(data),
        ],
      ),
    );
  }
}
