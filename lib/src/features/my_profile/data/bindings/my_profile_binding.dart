import 'package:get/get.dart';
import '../../../../core/data/models/database_model.dart';
import '../../presentation/controllers/my_profile_controller.dart';

import '../services/my_profile_service.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyProfileController(
        service: MyProfileService(
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
