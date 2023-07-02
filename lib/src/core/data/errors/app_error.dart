import 'package:get/get.dart';

import '../../presentation/widgets/custom_dialog.dart';

class AppError implements Exception {
  final String message;

  AppError({
    required this.message,
  });

  Future<void> showDialog() async {
    await Get.dialog(
      CustomDialog(
        title: 'Erro',
        content: message,
      ),
    );
  }

  factory AppError.generic() {
    return AppError(
      message:
          'Ocorreu um problema de comunicação com os nossos servidores, tente novamente em alguns instantes.',
    );
  }
}
