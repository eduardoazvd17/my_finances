import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/core/data/utils/app_routes.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';

class WelcomePageController extends GetxController {
  final AppController appController;
  final AuthService _authService;
  WelcomePageController({
    required this.appController,
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onInit() {
    _autoLogin();
    super.onInit();
  }

  final RxBool _isLoading = RxBool(true);
  bool get isLoading => _isLoading.value;

  Future<void> _autoLogin() async {
    _isLoading.value = true;
    final UserModel? user = await _authService.autoLogin();
    _isLoading.value = false;
    if (user != null) {
      appController.setUser(user);
      AppRoutes.goToFinancesPage();
    }
  }
}
