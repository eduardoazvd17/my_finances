import 'package:get/get.dart';
import 'package:myfinances/src/features/documents/data/models/document_model.dart';
import 'package:myfinances/src/features/documents/presentation/controllers/document_editor_controller.dart';

import '../../../../core/data/models/database_model.dart';
import '../services/document_editor_service.dart';

class DocumentEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () {
        final documentModel = Get.arguments as DocumentModel;
        return DocumentEditorController(
          documentModel: documentModel,
          documentEditorService: DocumentEditorService(
            documentModel: documentModel,
            database: Get.find<DatabaseModel>(),
          ),
        );
      },
    );
  }
}
