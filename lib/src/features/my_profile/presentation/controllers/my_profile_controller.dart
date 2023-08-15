import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';

import '../../../../core/data/errors/app_error.dart';
import '../../../../core/data/models/user_model.dart';
import '../../../../core/data/utils/app_routes.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../../data/services/my_profile_service.dart';

class MyProfileController extends GetxController {
  final MyProfileService _service;

  MyProfileController({
    required MyProfileService service,
  }) : _service = service;

  late final Rx<String?> _photoUrl;
  String? get photoUrl => _photoUrl.value;

  late final RxString _name;
  String get name => _name.value;

  late final RxString _nickname;
  String get nickname => _nickname.value;

  late final RxString _email;
  String get email => _email.value;

  late final RxString _passwordHash;
  String get passwordHash => _passwordHash.value;

  @override
  void onInit() {
    _photoUrl = Rx<String?>(AppController.instance.user!.photoUrl);
    _name = RxString(AppController.instance.user!.name);
    _nickname = RxString(AppController.instance.user!.nickname);
    _email = RxString(AppController.instance.user!.email);
    _passwordHash = RxString(AppController.instance.user!.password);
    super.onInit();
  }

  final nameController = TextEditingController();
  final nameFocus = FocusNode();

  final nicknameController = TextEditingController();
  final nicknameFocus = FocusNode();

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

  Future<void> changeName() async {
    FocusNode? focusNode;
    try {
      final String newName = nameController.text.trim();

      if (newName == AppController.instance.user!.name) {
        return;
      }

      LoadingWidget.dialog();

      if (newName.isEmpty) {
        focusNode = nameFocus;
        throw AppError(message: 'name-validation'.i18n());
      }

      final bool result = await _service.changeUserName(
        userId: AppController.instance.user!.id,
        newName: newName,
      );

      if (result) {
        final UserModel newUser = AppController.instance.user!.editAndCopy(
          photoUrl: AppController.instance.user!.photoUrl,
          nickname: AppController.instance.user!.nickname,
          name: newName,
        );
        _changeCurrentUser(newUser);
      }

      Get.close(2);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog().then((_) {
        focusNode?.requestFocus();
      });
    }
  }

  Future<void> changeNickname() async {
    try {
      final String newNickname = nicknameController.text.trim();

      if (newNickname == AppController.instance.user!.rawNickname) {
        return;
      }

      LoadingWidget.dialog();
      final bool result = await _service.changeUserNickname(
        userId: AppController.instance.user!.id,
        newNickname: newNickname.isEmpty ? null : newNickname,
      );

      if (result) {
        final UserModel newUser = AppController.instance.user!.editAndCopy(
          photoUrl: AppController.instance.user!.photoUrl,
          nickname: newNickname.isEmpty ? null : newNickname,
        );
        _changeCurrentUser(newUser);
      }

      Get.close(2);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
    }
  }

  Future<void> changePassword() async {
    FocusNode? focusNode;

    try {
      final String oldPassword = oldPasswordController.text.trim();
      if (oldPassword.isEmpty) return;

      LoadingWidget.dialog();

      final String newPassword = passwordController.text.trim();
      final String newPassword2 = password2Controller.text.trim();

      if (_md5Hash(oldPassword) != _passwordHash.value) {
        focusNode = oldPasswordFocus;
        throw AppError(message: 'old-password-validation'.i18n());
      }

      if (newPassword == oldPassword) {
        focusNode = passwordFocus;
        passwordController.clear();
        password2Controller.clear();
        throw AppError(message: 'new-password-validation'.i18n());
      }

      if (newPassword.length < 8) {
        focusNode = passwordFocus;
        throw AppError(message: 'register-password-validation'.i18n());
      }

      if (newPassword != newPassword2) {
        focusNode = password2Focus;
        throw AppError(message: 'new-password2-validation'.i18n());
      }

      final bool result = await _service.changeUserPassword(
        userId: AppController.instance.user!.id,
        newPassword: _md5Hash(newPassword),
      );

      if (result) {
        final UserModel newUser = AppController.instance.user!.editAndCopy(
          photoUrl: AppController.instance.user!.photoUrl,
          nickname: AppController.instance.user!.nickname,
          password: _md5Hash(newPassword),
        );
        _changeCurrentUser(newUser);
      }

      Get.close(2);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog().then((_) {
        focusNode?.requestFocus();
      });
    }
  }

  Future<void> deleteAccount() async {
    try {
      LoadingWidget.dialog();

      final bool result = await _service.deleteAccount(
        userId: AppController.instance.user!.id,
      );

      if (result) {
        AppController.instance.logout();
      }

      Get.close(1);
    } on AppError catch (appError) {
      Get.close(1);
      appError.showDialog();
    }
  }

  String _md5Hash(String value) {
    return md5.convert(utf8.encode(value)).toString();
  }

  void _changeCurrentUser(UserModel user) {
    AppController.instance.setUser(user);
    _photoUrl.value = user.photoUrl;
    _name.value = user.name;
    _nickname.value = user.nickname;
    _email.value = user.email;
    _passwordHash.value = user.password;
    Get.forceAppUpdate();
  }
}
