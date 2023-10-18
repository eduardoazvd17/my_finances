import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';

import '../../../../core/presentation/widgets/button_widget.dart';
import '../controllers/my_profile_controller.dart';

class ChangePasswordPage extends GetWidget<MyProfileController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('change-password-button'.i18n()),
      ),
      body: Center(
        child: ScrollViewWidget(
          child: Column(
            children: [
              TextFieldWidget(
                autofocus: true,
                label: 'old-password-label'.i18n(),
                hint: 'old-password-hint'.i18n(),
                obscureText: true,
                controller: controller.oldPasswordController,
                focusNode: controller.oldPasswordFocus,
                onSubmitted: (_) => controller.passwordFocus.requestFocus(),
                textInputAction: TextInputAction.next,
              ),
              TextFieldWidget(
                label: 'new-password-label'.i18n(),
                hint: 'new-password-hint'.i18n(),
                obscureText: true,
                controller: controller.passwordController,
                focusNode: controller.passwordFocus,
                onSubmitted: (_) => controller.password2Focus.requestFocus(),
                textInputAction: TextInputAction.next,
              ),
              TextFieldWidget(
                label: 'new-password2-label'.i18n(),
                hint: 'new-password2-hint'.i18n(),
                obscureText: true,
                controller: controller.password2Controller,
                focusNode: controller.password2Focus,
                onSubmitted: (_) => controller.changePassword(),
                textInputAction: TextInputAction.done,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ButtonWidget(
                  icon: Icons.lock_person_outlined,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  text: 'change-button'.i18n(),
                  onTap: controller.changePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
