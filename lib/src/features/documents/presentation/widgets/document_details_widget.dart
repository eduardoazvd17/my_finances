import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/documents/data/enums/document_type.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/data/utils/date_time_utils.dart';
import '../../data/models/document_model.dart';

class DocumentDetailsWidget extends StatelessWidget {
  final DocumentModel documentModel;
  final bool showHeader;
  const DocumentDetailsWidget({
    super.key,
    required this.documentModel,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
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
        if (showHeader) const Divider(),
        _textTile(
          label: 'document-type-label'.i18n(),
          data: documentModel.type.title,
          description: documentModel.type.description,
        ),
        _textTile(
          label: 'document-creation-date-label'.i18n(),
          data: DateTimeUtils.formatFullDate(
            documentModel.creationDate,
          ),
        ),
      ],
    );
  }

  Widget _textTile({
    required String label,
    required String data,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
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
          if (description != null)
            Text(
              description,
              style: TextStyle(
                color: AppThemes.commonColor,
              ),
            ),
        ],
      ),
    );
  }
}
