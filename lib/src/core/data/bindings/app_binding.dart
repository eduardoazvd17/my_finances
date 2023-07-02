import 'package:get/get.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
  }
}
