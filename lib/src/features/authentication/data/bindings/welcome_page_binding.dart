import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/welcome_page_controller.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WelcomePageController(
        authService: AuthService(
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
