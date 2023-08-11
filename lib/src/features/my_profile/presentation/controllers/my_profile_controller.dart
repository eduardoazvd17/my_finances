import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/controllers/app_controller.dart';

class MyProfileController extends GetxController {
  late final RxString _name;
  late final RxString _email;
  late final RxString _passwordHash;

  @override
  void onInit() {
    _name = RxString(AppController.instance.user!.name);
    _email = RxString(AppController.instance.user!.email);
    _passwordHash = RxString(AppController.instance.user!.password);
    super.onInit();
  }

  String get name => _name.value;
  String get email => _email.value;
  String get passwordHash => _passwordHash.value;

  final nameController = TextEditingController();
  final nameFocus = FocusNode();

  final oldPasswordController = TextEditingController();
  final oldPasswordFocus = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  final password2Controller = TextEditingController();
  final password2Focus = FocusNode();

  Future<bool> editName() async {
    return true;
  }

  Future<bool> editPassword() async {
    return true;
  }
}
