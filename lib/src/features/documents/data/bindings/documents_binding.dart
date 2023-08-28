import 'package:get/get.dart';
import '../../../../core/data/models/database_model.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../services/documents_service.dart';
import '../../presentation/controllers/documents_controller.dart';

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
