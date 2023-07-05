import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/bindings/app_binding.dart';
import 'package:myfinances/src/core/data/models/database_model.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';

import 'firebase_options.dart';
import 'src/core/data/utils/app_routes.dart';
import 'src/core/data/utils/app_themes.dart';
import 'src/core/data/utils/life_cycle_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(
    () => DatabaseModel(
      firestore: FirebaseFirestore.instanceFor(app: firebaseApp),
      credentialsManager: CredentialsManager(
        storageKey: firebaseApp.options.appId,
        useAndroidEncryptedSharedPreferences: true,
      ),
    ),
    fenix: true,
  );

  Get.lazyPut(() => I18nController(), fenix: true);
  runApp(const MyFinancesApp());
}

class MyFinancesApp extends GetWidget<I18nController> {
  const MyFinancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (_, child) => LifeCycleHandler(child: child!),
      debugShowCheckedModeBanner: false,
      title: 'app-name'.i18n(),
      locale: controller.selectedLocale,
      localizationsDelegates: controller.localizationsDelegates,
      supportedLocales: controller.supportedLocales,
      localeResolutionCallback: controller.localeResolutionCallback,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.getGetPages(),
    );
  }
}
