import 'package:get/get.dart';
import 'package:myfinances/src/features/documents/data/services/document_editor_service.dart';

import '../../data/models/document_model.dart';

class DocumentEditorController extends GetxController {
  final DocumentModel documentModel;
  final DocumentEditorService _documentEditorService;
  DocumentEditorController({
    required this.documentModel,
    required DocumentEditorService documentEditorService,
  }) : _documentEditorService = documentEditorService;
}
