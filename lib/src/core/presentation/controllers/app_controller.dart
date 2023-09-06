import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../views/auth_overlay_view.dart';
import '../../../features/authentication/data/services/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/utils/app_routes.dart';

class AppController extends GetxController {
  final AuthService _authService;
  AppController({
    required AuthService authService,
  }) : _authService = authService;

  @override
  void onInit() {
    _loadAppVersion();
    super.onInit();
  }

  static AppController get instance => Get.find<AppController>();

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;
  void setUser(UserModel? value) => _user.value = value;

  Future<void> logout({bool withoutNavigate = false}) async {
    await _authService.logout();
    setIsBiometricsEnabled(false, disableAuthCheck: true);
    if (!withoutNavigate) {
      AppRoutes.goToWelcomePage();
    }
    _user.value = null;
  }

  final RxString _appVersion = RxString('...');
  String get appVersion => _appVersion.value;

  Future<void> _loadAppVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String version = packageInfo.version;
      final String buildNumber = packageInfo.buildNumber;
      _appVersion.value = 'v$version+$buildNumber (Alpha)';
    } catch (_) {
      _appVersion.value = '';
    }
  }

  final RxBool _canShowAuthOverlay = RxBool(false);
  final RxBool _canEnableBiometrics = RxBool(false);
  bool get canEnableBiometrics => _canEnableBiometrics.value;
  final RxBool _isBiometricsEnabled = RxBool(false);
  bool get isBiometricsEnabled => _isBiometricsEnabled.value;

  Future<void> checkBiometricsSettings() async {
    final bool canEnable = await _authService.checkIfCanEnableBiometrics();
    _canEnableBiometrics.value = canEnable;
    if (canEnable) {
      final bool isEnabled = await _authService.checkIfBiometricsIsEnabled();
      _isBiometricsEnabled.value = isEnabled;
    }
  }

  Future<void> setIsBiometricsEnabled(
    bool value, {
    bool disableAuthCheck = false,
  }) async {
    _canShowAuthOverlay.value = false;
    if (value && canEnableBiometrics) {
      final result = await _authService.enableBiometrics();
      _isBiometricsEnabled.value = result;
      _canShowAuthOverlay.value = result;
    } else {
      final bool authResult = isBiometricsEnabled && !disableAuthCheck
          ? (await _authService.requestAuth())
          : true;
      if (authResult) {
        _authService.disableBiometrics();
        _isBiometricsEnabled.value = false;
      }
    }

    await checkBiometricsSettings();
  }

  Future<bool> requestAuth() async {
    if (kIsWeb) return true;

    _canShowAuthOverlay.value = false;

    final bool result;
    if (isBiometricsEnabled && canEnableBiometrics) {
      final authResult = await _authService.requestAuth();
      result = authResult;
      if (authResult) {
        _canShowAuthOverlay.value = true;
      }
    } else {
      result = true;
    }

    return result;
  }

  Future<void> showAuthOverlay() async {
    if (_pauseAuthOverlay.value) return;
    if (!Get.currentRoute.contains(AppRoutes.initialRoute) &&
        user != null &&
        isBiometricsEnabled &&
        canEnableBiometrics &&
        _canShowAuthOverlay.value &&
        !kIsWeb) {
      _canShowAuthOverlay.value = false;
      Get.dialog(
        const AuthOverlayView(),
        barrierDismissible: false,
        useSafeArea: false,
      );
    }
  }

  final RxBool _pauseAuthOverlay = RxBool(false);
  void pauseAuthOverlay() => _pauseAuthOverlay.value = true;
  void resumeAuthOverlay() => _pauseAuthOverlay.value = false;

  Future<void> closeAuthOverlay() async {
    final result = await requestAuth();
    if (result) {
      Get.close(1);
    }
  }
}
