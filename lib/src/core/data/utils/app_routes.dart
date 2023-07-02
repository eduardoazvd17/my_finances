import 'package:get/get.dart';
import 'package:myfinances/src/features/authentication/presentation/pages/welcome_page.dart';
import 'package:myfinances/src/features/finances_page/presentation/pages/finances_page.dart';

import '../../../features/authentication/data/bindings/welcome_page_binding.dart';
import '../../../features/finances_page/data/bindings/finances_binding.dart';

class AppRoutes {
  /// ROUTE NAMES
  static const String _welcome = "/welcome";
  static const String _finances = "/finances";

  /// INITIAL ROUTES
  static String get welcomeRoute => _welcome;

  /// NAVIGATE
  static void goToWelcomePage() => _navigate(_welcome, offAll: true);
  static void goToFinancesPage() => _navigate(_finances, offAll: true);

  /// GET PAGES
  static List<GetPage> getGetPages() {
    return [
      GetPage(
        name: _welcome,
        page: () => const WelcomePage(),
        binding: WelcomePageBinding(),
      ),
      GetPage(
        name: _finances,
        page: () => const FinancesPage(),
        binding: FinancesBinding(),
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
}
