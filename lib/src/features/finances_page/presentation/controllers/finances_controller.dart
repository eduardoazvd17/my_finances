import 'package:get/get.dart';
import 'package:myfinances/src/features/finances_page/data/models/document_model.dart';
import 'package:myfinances/src/features/finances_page/data/services/finances_service.dart';

import '../../../../core/data/errors/app_error.dart';

class FinancesController extends GetxController {
  final FinancesService _financesService;
  FinancesController({
    required FinancesService financesService,
  }) : _financesService = financesService;

  @override
  void onInit() {
    loadUserDocuments();
    super.onInit();
  }

  final RxList<DocumentModel> _userDocuments = RxList<DocumentModel>();
  List<DocumentModel> get userDocuments => _userDocuments.toList();
  Future<void> loadUserDocuments() async {
    try {
      _userDocuments.value = await _financesService.getUserDocuments();
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
    }
  }
}
