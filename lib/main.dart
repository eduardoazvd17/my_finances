import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/bindings/app_binding.dart';
import 'package:myfinances/src/core/presentation/controllers/i18n_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/features/authentication/presentation/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(
    () => FirebaseFirestore.instanceFor(app: firebaseApp),
    fenix: true,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() async => prefs, fenix: true);

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
        initialBinding: AppBinding(),
        home: const WelcomePage(),
      ),
    );
  }
}
