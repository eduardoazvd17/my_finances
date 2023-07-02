import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

import '../controllers/auth_controller.dart';

class WelcomePage extends GetWidget<AuthController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(
                verticalAlign: true,
                size: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'welcome-text'.i18n(),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Text(
                  'slogan-text'.i18n(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Obx(
                () {
                  if (controller.isLoading) {
                    return const LoadingWidget(inline: false);
                  } else {
                    return _getLoginAndRegisterButtons(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoginAndRegisterButtons(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  text: 'login-button'.i18n(),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onTap: controller.goToLoginPage,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  text: 'register-button'.i18n(),
                  onTap: controller.goToRegisterPage,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
