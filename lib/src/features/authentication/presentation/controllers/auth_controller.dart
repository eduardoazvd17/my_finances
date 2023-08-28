import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/user_model.dart';
import '../../../../core/data/utils/app_routes.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  AuthController({
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onInit() {
    AppController.instance.checkBiometricsSettings().then((_) async {
      await autoLogin();
    });
    super.onInit();
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final password2Focus = FocusNode();

  void _clearAllFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    password2Controller.clear();
  }

  final RxString _lastUserName = RxString('');
  String get lastUserName => _lastUserName.value;

  Future<void> autoLogin() async {
    _isLoading.value = true;
    final UserModel? userModel = await _authService.autoLogin();
    if (userModel != null) {
      _lastUserName.value = '\n${userModel.name}';
      if (await _checkBiometrics()) {
        AppController.instance.setUser(userModel);
        AppRoutes.goToDocumentsPage();
      } else {
        _showBiometricsTryAgainButton.value = true;
      }
    } else {
      _showBiometricsTryAgainButton.value = false;
      _isLoading.value = false;
    }
  }

  Future<void> cancelAutoLogin() async {
    _showBiometricsTryAgainButton.value = false;
    _isLoading.value = true;
    await AppController.instance.logout(withoutNavigate: true);
    _isLoading.value = false;
  }

  final RxBool _showBiometricsTryAgainButton = RxBool(false);
  bool get showBiometricsTryAgainButton => _showBiometricsTryAgainButton.value;

  Future<bool> _checkBiometrics() async {
    return await AppController.instance.requestAuth();
  }

  Future<void> makeLogin() async {
    FocusNode? focusNode;
    try {
      LoadingWidget.dialog();

      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      if (!email.isEmail) {
        focusNode = emailFocus;
        throw AppError(message: 'login-email-validation'.i18n());
      }

      if (password.isEmpty) {
        focusNode = passwordFocus;
        throw AppError(message: 'login-password-validation'.i18n());
      }

      final UserModel? userModel = await _authService.login(
        email: email,
        password: password,
      );

      if (userModel != null) {
        AppController.instance.setUser(userModel);
        AppRoutes.goToDocumentsPage();
      } else {
        throw AppError.generic();
      }
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog().then((_) => focusNode?.requestFocus());
    }
  }

  Future<void> makeRegister() async {
    FocusNode? focusNode;
    try {
      LoadingWidget.dialog();

      final String name = nameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String password2 = password2Controller.text.trim();

      if (name.isEmpty) {
        focusNode = nameFocus;
        throw AppError(message: 'name-validation'.i18n());
      }

      if (!email.isEmail) {
        focusNode = emailFocus;
        throw AppError(message: 'register-email-validation'.i18n());
      }

      if (password.length < 8) {
        focusNode = passwordFocus;
        throw AppError(message: 'register-password-validation'.i18n());
      }

      if (password != password2) {
        focusNode = password2Focus;
        throw AppError(message: 'register-password2-validation'.i18n());
      }

      final UserModel? userModel = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      if (userModel != null) {
        AppController.instance.setUser(userModel);
        AppRoutes.goToDocumentsPage();
      } else {
        throw AppError.generic();
      }
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog().then((_) {
        focusNode?.requestFocus();
      });
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
