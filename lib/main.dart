import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import 'src/features/authentication/presentation/pages/welcome_page.dart';

void main() {
  Get.lazyPut(() => I18nController(), fenix: true);
  runApp(const MyApp());
}

class MyApp extends GetWidget<I18nController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app-name'.i18n(),
        locale: controller.selectedLocale,
        localizationsDelegates: controller.localizationsDelegates,
        supportedLocales: controller.supportedLocales,
        localeResolutionCallback: controller.localeResolutionCallback,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          useMaterial3: true,
        ),
        home: const WelcomePage(),
      ),
    );
  }
}
