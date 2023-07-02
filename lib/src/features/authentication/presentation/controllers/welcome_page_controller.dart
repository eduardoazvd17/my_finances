import 'package:get/get.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';

class WelcomePageController extends GetxController {
  final AuthService _authService;
  WelcomePageController({
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onInit() {
    _checkIfUserIsLoggedIn();
    super.onInit();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    _authService;
  }
}
