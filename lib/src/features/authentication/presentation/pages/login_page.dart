import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/authentication/presentation/controllers/auth_controller.dart';

class LoginPage extends GetWidget<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('login-button'.i18n()),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
