import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

import '../widgets/bottom_sheet_modal_widget.dart';
import '../widgets/custom_dialog.dart';

class SettingsView extends GetWidget<AppController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomSheetModalWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'settings-text'.i18n(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              value: controller.canEnableBiometrics
                  ? controller.isBiometricsEnabled
                  : false,
              onChanged: controller.canEnableBiometrics
                  ? controller.setIsBiometricsEnabled
                  : null,
              title: Text('enable-biometrics-button'.i18n()),
              subtitle: controller.canEnableBiometrics
                  ? null
                  : Text(
                      "*${'cannot-enable-biometrics-text'.i18n()}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    title: 'logout-button'.i18n(),
                    content: 'logout-confirmation-text'.i18n(),
                    onConfirm: controller.logout,
                  ),
                );
              },
              trailing: const Icon(Icons.exit_to_app),
              iconColor: Colors.red,
              title: Text('logout-button'.i18n()),
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
