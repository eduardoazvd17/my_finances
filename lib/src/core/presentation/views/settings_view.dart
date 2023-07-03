import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

import '../widgets/bottom_sheet_modal_widget.dart';

class SettingsView extends GetWidget<AppController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
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
          Obx(
            () {
              return SwitchListTile(
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
                        'cannot-enable-biometrics-text'.i18n(),
                        style: const TextStyle(color: Colors.red),
                      ),
              );
            },
          ),
          const Divider(),
          ListTile(
            onTap: controller.logout,
            trailing: const Icon(Icons.exit_to_app),
            iconColor: Colors.red,
            title: Text('logout-button'.i18n()),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
