import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/finances_page/data/services/finances_service.dart';
import 'package:myfinances/src/features/finances_page/presentation/controllers/finances_controller.dart';

class FinancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FinancesController(
        financesService: FinancesService(
          userModel: Get.find<AppController>().user,
          database: Get.find<DatabaseModel>(),
        ),
      ),
    );
  }
}
