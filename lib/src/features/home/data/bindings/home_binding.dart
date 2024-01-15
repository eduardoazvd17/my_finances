import 'package:get/get.dart';
import '../../../../core/data/models/database_model.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../services/home_service.dart';
import '../../presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        documentsService: HomeService(
          userModel: AppController.instance.user!,
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
