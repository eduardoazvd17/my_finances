import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

import '../../../../core/presentation/widgets/scaffold_widget.dart';

class RegisterPage extends GetWidget<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('register-button'.i18n()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInputTile(
              label: 'register-name-label'.i18n(),
              hint: 'register-name-hint'.i18n(),
              controller: controller.nameController,
            ),
            _buildInputTile(
              label: 'register-email-label'.i18n(),
              hint: 'register-email-hint'.i18n(),
              controller: controller.emailController,
            ),
            _buildInputTile(
              label: 'register-password-label'.i18n(),
              hint: 'register-password-hint'.i18n(),
              controller: controller.passwordController,
            ),
            _buildInputTile(
              label: 'register-password2-label'.i18n(),
              hint: 'register-password2-hint'.i18n(),
              controller: controller.password2Controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputTile({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
