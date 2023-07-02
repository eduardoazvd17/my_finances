import 'package:get/get.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/finances_page/presentation/controllers/finances_controller.dart';

class FinancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FinancesController(
        appController: Get.find<AppController>(),
      ),
    );
  }
}
