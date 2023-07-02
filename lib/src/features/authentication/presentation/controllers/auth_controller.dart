import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/core/data/utils/app_routes.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';

class AuthController extends GetxController {
  final AppController appController;
  final AuthService _authService;
  AuthController({
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  void _clearAllFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    password2Controller.clear();
  }

  Future<void> _autoLogin() async {
    _isLoading.value = true;
    final UserModel? user = await _authService.autoLogin();
    _isLoading.value = false;
    if (user != null) {
      appController.setUser(user);
      AppRoutes.goToFinancesPage();
    }
  }

  void goToLoginPage() {
    _clearAllFields();
    AppRoutes.goToLoginPage();
  }

  void goToRegisterPage() {
    _clearAllFields();
    AppRoutes.goToRegisterPage();
  }
}
