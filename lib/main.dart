import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/data/bindings/app_binding.dart';
import 'package:myfinances/src/core/data/enums/app_theme_mode.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import 'firebase_options.dart';
import 'src/core/data/utils/app_routes.dart';
import 'src/core/data/utils/app_themes.dart';
import 'src/core/data/utils/life_cycle_handler.dart';
import 'src/core/presentation/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(
    () => DatabaseModel(
      credentialsManager: CredentialsManager(
        storageKey: firebaseApp.options.appId,
        useAndroidEncryptedSharedPreferences: true,
      ),
      firestore: FirebaseFirestore.instanceFor(app: firebaseApp),
      storage: FirebaseStorage.instanceFor(app: firebaseApp),
    ),
    fenix: true,
  );
  Get.lazyPut(() => I18nController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  runApp(const MyFinancesApp());
}

class MyFinancesApp extends GetWidget<I18nController> {
  const MyFinancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      return FlutterWebFrame(
        builder: (context) {
          return Obx(
            () => GetMaterialApp(
              builder: (_, child) => LifeCycleHandler(child: child!),
              debugShowCheckedModeBanner: false,
              title: controller.appName,
              onGenerateTitle: (_) => controller.appName,
              locale: controller.selectedLocale,
              localizationsDelegates: controller.localizationsDelegates,
              supportedLocales: controller.supportedLocales,
              localeResolutionCallback: controller.localeResolutionCallback,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              themeMode: themeController.selectedTheme.themeMode,
              initialBinding: AppBinding(),
              initialRoute: AppRoutes.initialRoute,
              getPages: AppRoutes.getGetPages(),
            ),
          );
        },
        maximumSize: Size(800, Get.height),
        enabled: kIsWeb,
        backgroundColor: AppThemes.commonColor,
      );
    });
  }
}
