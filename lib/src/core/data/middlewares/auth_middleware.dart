import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

import '../utils/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppController.instance.user == null) {
      return RouteSettings(name: AppRoutes.initialRoute);
    }
    return super.redirect(route);
  }
}
