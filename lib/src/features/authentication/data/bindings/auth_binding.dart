import 'package:get/get.dart';
import '../../../../core/data/models/database_model.dart';
import '../services/auth_service.dart';
import '../../presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(
        authService: AuthService(
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
