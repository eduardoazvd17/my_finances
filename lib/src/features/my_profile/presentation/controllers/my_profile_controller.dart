import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/utils/app_routes.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../../data/services/my_profile_service.dart';

class MyProfileController extends GetxController {
  final MyProfileService _service;
  
  MyProfileController({
    required MyProfileService service,
  }) : _service = service;

  late final RxString _name;
  late final RxString _nickname;
  late final Rx<String?> _photoUrl;
  late final RxString _email;
  late final RxString _passwordHash;

  @override
  void onInit() {
    _name = RxString(AppController.instance.user!.name);
    _nickname = RxString(AppController.instance.user!.nickname);
    _photoUrl = Rx<String?>(AppController.instance.user!.photoUrl);
    _email = RxString(AppController.instance.user!.email);
    _passwordHash = RxString(AppController.instance.user!.password);
    super.onInit();
  }

  String get name => _name.value;
  String get nickname => _nickname.value;
  String? get photoUrl => _photoUrl.value;
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

  void goToChangePasswordPage() {
    oldPasswordController.clear();
    passwordController.clear();
    password2Controller.clear();
    AppRoutes.goToMyChangePasswordPage();
  }

  Future<void> changeName() async {}

  Future<void> changeNickname() async {}

  Future<void> changePassword() async {}

  Future<void> deleteAccount() async {}
}
