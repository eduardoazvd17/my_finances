import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/features/my_profile/presentation/controllers/my_profile_controller.dart';

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
