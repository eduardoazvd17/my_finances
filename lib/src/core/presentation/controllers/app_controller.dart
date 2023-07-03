import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';
import 'package:myfinances/src/features/authentication/data/services/auth_service.dart';

import '../../data/utils/app_routes.dart';

class AppController extends GetxController {
  final AuthService _authService;
  AppController({
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onInit() {
    _checkBiometricsSettings();
    super.onInit();
  }

  static AppController get instance => Get.find<AppController>();

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;
  void setUser(UserModel? value) => _user.value = value;

  Future<void> logout({bool withoutNavigate = false}) async {
    await _authService.logout();
    if (!withoutNavigate) {
      AppRoutes.goToWelcomePage();
    }
    _user.value = null;
  }

  final RxBool _canEnableBiometrics = RxBool(false);
  bool get canEnableBiometrics => _canEnableBiometrics.value;
  final RxBool _isBiometricsEnabled = RxBool(false);
  bool get isBiometricsEnabled => _isBiometricsEnabled.value;

  Future<void> _checkBiometricsSettings() async {
    final bool canEnable = await _authService.checkIfCanEnableBiometrics();
    _canEnableBiometrics.value = canEnable;
    if (canEnable) {
      final bool isEnabled = await _authService.checkIfBiometricsIsEnabled();
      _isBiometricsEnabled.value = isEnabled;
    }
  }

  Future<void> setIsBiometricsEnabled(bool value) async {
    if (!canEnableBiometrics) return;

    if (value) {
      final result = await _authService.enableBiometrics();
      _isBiometricsEnabled.value = result;
    } else {
      _authService.disableBiometrics();
      _isBiometricsEnabled.value = false;
    }

    await _checkBiometricsSettings();
  }

  Future<bool> requestAuth() async {
    if (isBiometricsEnabled && canEnableBiometrics) {
      final authResult = await _authService.requestAuth();
      return authResult;
    }
    return true;
  }
}
