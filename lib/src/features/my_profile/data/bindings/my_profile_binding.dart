import 'package:get/get.dart';
import 'package:myfinances/src/features/my_profile/presentation/controllers/my_profile_controller.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyProfileController(),
    );
  }
}
