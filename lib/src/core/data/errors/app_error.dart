import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../presentation/widgets/custom_dialog.dart';

class AppError implements Exception {
  final String message;

  AppError({
    required this.message,
  });

  Future<void> showDialog() async {
    await Get.dialog(
      CustomDialog(
        title: 'error-text'.i18n(),
        content: message,
      ),
      name: 'error',
      barrierColor: Colors.black87,
    );
  }

  factory AppError.generic() {
    return AppError(message: 'generic-error'.i18n());
  }
}
