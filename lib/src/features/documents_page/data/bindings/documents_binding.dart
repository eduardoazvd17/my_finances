import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/documents_page/data/services/documents_service.dart';
import 'package:myfinances/src/features/documents_page/presentation/controllers/documents_controller.dart';

class DocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DocumentsController(
        documentsService: DocumentsService(
          userModel: AppController.instance.user!,
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
