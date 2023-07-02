import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';

class RegisterPage extends GetWidget<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('register-button'.i18n()),
      ),
      body: Center(
        child: ScrollViewWidget(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 50.0, top: 16),
                child: AppLogo(),
              ),
              TextFieldWidget(
                icon: CupertinoIcons.person,
                label: 'register-name-label'.i18n(),
                hint: 'register-name-hint'.i18n(),
                controller: controller.nameController,
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                focusNode: controller.nameFocus,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => controller.emailFocus.requestFocus(),
              ),
              TextFieldWidget(
                icon: CupertinoIcons.mail,
                label: 'register-email-label'.i18n(),
                hint: 'register-email-hint'.i18n(),
                controller: controller.emailController,
                textInputType: TextInputType.emailAddress,
                focusNode: controller.emailFocus,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => controller.passwordFocus.requestFocus(),
              ),
              TextFieldWidget(
                icon: CupertinoIcons.lock,
                label: 'register-password-label'.i18n(),
                hint: 'register-password-hint'.i18n(),
                controller: controller.passwordController,
                textInputType: TextInputType.text,
                obscureText: true,
                focusNode: controller.passwordFocus,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => controller.password2Focus.requestFocus(),
              ),
              TextFieldWidget(
                icon: CupertinoIcons.lock_shield,
                label: 'register-password2-label'.i18n(),
                hint: 'register-password2-hint'.i18n(),
                controller: controller.password2Controller,
                textInputType: TextInputType.text,
                obscureText: true,
                focusNode: controller.password2Focus,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => controller.makeRegister(),
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
                        text: 'make-register-button'.i18n(),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        onTap: controller.makeRegister,
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
