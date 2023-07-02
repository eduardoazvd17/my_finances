import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';

import '../../data/utils/app_routes.dart';

class AppController extends GetxController {
  final AuthService _authService;
  AppController({
    required AuthService authService,
  }) : _authService = authService;

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;
  void setUser(UserModel? value) => _user.value = value;
  Future<void> logout() async {
    await _authService.logout();
    AppRoutes.goToWelcomePage();
    _user.value = null;
  }
}
