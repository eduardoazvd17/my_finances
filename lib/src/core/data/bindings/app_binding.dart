import 'package:get/get.dart';
import '../../presentation/controllers/app_controller.dart';

import '../../../features/authentication/data/services/auth_service.dart';
import '../models/database_model.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AppController(
        authService: AuthService(
          database: Get.find<DatabaseModel>(),
        ),
      ),
      permanent: true,
    );
  }
}
