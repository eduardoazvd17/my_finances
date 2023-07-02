import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

import '../../../../core/presentation/widgets/text_field_widget.dart';

class LoginPage extends GetWidget<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('login-button'.i18n()),
      ),
      body: Column(
        children: [
          TextFieldWidget(
            icon: CupertinoIcons.mail,
            label: 'login-email-label'.i18n(),
            hint: 'login-email-hint'.i18n(),
            controller: controller.emailController,
          ),
          TextFieldWidget(
            icon: CupertinoIcons.lock,
            label: 'login-password-label'.i18n(),
            hint: 'login-password-hint'.i18n(),
            controller: controller.passwordController,
          ),
        ],
      ),
    );
  }
}
