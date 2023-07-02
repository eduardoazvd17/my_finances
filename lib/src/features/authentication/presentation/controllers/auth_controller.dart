import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/errors/app_error.dart';
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
    final UserModel? userModel = await _authService.autoLogin();
    _isLoading.value = false;
    if (userModel != null) {
      appController.setUser(userModel);
      AppRoutes.goToFinancesPage();
    }
  }

  Future<void> makeLogin() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      if (!email.isEmail) {
        throw AppError(message: 'login-email-validation'.i18n());
      }

      if (password.isEmpty) {
        throw AppError(message: 'login-password-validation'.i18n());
      }

      final UserModel? userModel = await _authService.login(
        email: email,
        password: password,
      );

      if (userModel != null) {
        appController.setUser(userModel);
        AppRoutes.goToFinancesPage();
      }
    } on AppError catch (appError) {
      appError.showDialog();
    }
  }

  Future<void> makeRegister() async {
    try {
      final String name = nameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String password2 = password2Controller.text.trim();

      if (name.isEmpty) {
        throw AppError(message: 'register-name-validation'.i18n());
      }

      if (!email.isEmail) {
        throw AppError(message: 'register-email-validation'.i18n());
      }

      if (password.length < 8) {
        throw AppError(message: 'register-password-validation'.i18n());
      }

      if (password != password2) {
        throw AppError(message: 'register-password2-validation'.i18n());
      }

      final UserModel? userModel = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      if (userModel != null) {
        appController.setUser(userModel);
        AppRoutes.goToFinancesPage();
      }
    } on AppError catch (appError) {
      appError.showDialog();
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
