import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../features/authentication/presentation/pages/login_page.dart';
import '../../../features/authentication/presentation/pages/register_page.dart';
import '../../../features/authentication/presentation/pages/welcome_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/my_profile/data/bindings/my_profile_binding.dart';
import '../../../features/my_profile/presentation/pages/change_password_page.dart';

import '../../../features/authentication/data/bindings/auth_binding.dart';
import '../../../features/home/data/bindings/home_binding.dart';
import '../../../features/my_profile/presentation/pages/my_profile_page.dart';
import '../../../features/my_profile/presentation/pages/my_profile_picture_page.dart';
import '../middlewares/auth_middleware.dart';

class AppRoutes {
  static const String _welcome = "/welcome";
  static const String _login = "/login";
  static const String _register = "/register";
  static const String _home = "/home";
  static const String _myProfile = "/myProfile";
  static const String _changePassword = "$_myProfile/changePassword";
  static const String _profilePicture = "$_myProfile/profilePicture";

  static String get initialRoute => _welcome;

  static void goToWelcomePage() => _navigate(_welcome, offAll: true);
  static void goToLoginPage() => _navigate(_login);
  static void goToRegisterPage() => _navigate(_register);
  static void goToHomePage() => _navigate(_home, offAll: true);

  static void goToMyProfilePage() => _navigate(_myProfile);
  static void goToChangePasswordPage() => _navigate(_changePassword);
  static void goToProfilePicturePage({required String url}) => _navigate(
        _profilePicture,
        arguments: url,
      );

  static List<GetPage> getGetPages() {
    return [
      GetPage(
        name: _welcome,
        page: () => const WelcomePage(),
        binding: AuthBinding(),
        transition: _getTransition(_welcome),
      ),
      GetPage(
        name: _login,
        page: () => const LoginPage(),
        binding: AuthBinding(),
        transition: _getTransition(_login),
      ),
      GetPage(
        name: _register,
        page: () => const RegisterPage(),
        binding: AuthBinding(),
        transition: _getTransition(_register),
      ),
      GetPage(
        name: _home,
        page: () => const HomePage(),
        binding: HomeBinding(),
        transition: _getTransition(_home),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: _myProfile,
        page: () => const MyProfilePage(),
        binding: MyProfileBinding(),
        transition: _getTransition(_myProfile),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: _changePassword,
        page: () => const ChangePasswordPage(),
        binding: MyProfileBinding(),
        transition: _getTransition(_changePassword),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: _profilePicture,
        page: () => const MyProfilePicturePage(),
        transition: _getTransition(_profilePicture),
        middlewares: [AuthMiddleware()],
      ),
    ];
  }

  static Future<T?> _navigate<T>(
    String route, {
    bool offAll = false,
    Map<String, String>? parameters,
    dynamic arguments,
  }) async {
    if (offAll) {
      return await Get.offAllNamed<T>(
        route,
        parameters: parameters,
        arguments: arguments,
      );
    } else {
      return await Get.toNamed<T>(
        route,
        parameters: parameters,
        arguments: arguments,
      );
    }
  }

  static Transition _getTransition(String route) {
    final List<String> downToUpRoutes = [
      _profilePicture,
    ];

    if (kIsWeb || downToUpRoutes.contains(route)) {
      return Transition.downToUp;
    } else {
      return Transition.cupertino;
    }
  }
}
