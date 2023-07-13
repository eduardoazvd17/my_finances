import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

import '../../../../core/data/utils/app_routes.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';

class LoginPage extends GetWidget<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        leading: Get.previousRoute != AppRoutes.initialRoute
            ? IconButton(
                onPressed: () => AppRoutes.goToWelcomePage(),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: Text('login-button'.i18n()),
      ),
      body: Center(
        child: ScrollViewWidget(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 16),
                child: AppLogo(),
              ),
              AutofillGroup(
                child: Column(
                  children: [
                    TextFieldWidget(
                      autofillHints: const [AutofillHints.email],
                      icon: CupertinoIcons.mail,
                      label: 'login-email-label'.i18n(),
                      hint: 'login-email-hint'.i18n(),
                      controller: controller.emailController,
                      textInputType: TextInputType.emailAddress,
                      focusNode: controller.emailFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        controller.passwordFocus.requestFocus();
                      },
                    ),
                    TextFieldWidget(
                      autofillHints: const [AutofillHints.password],
                      icon: CupertinoIcons.lock,
                      label: 'login-password-label'.i18n(),
                      hint: 'login-password-hint'.i18n(),
                      controller: controller.passwordController,
                      textInputType: TextInputType.text,
                      obscureText: true,
                      focusNode: controller.passwordFocus,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => controller.makeLogin(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        text: 'make-login-button'.i18n(),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        onTap: controller.makeLogin,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
