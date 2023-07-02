import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(
        appController: Get.find<AppController>(),
        authService: AuthService(
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
