import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

import '../controllers/finances_controller.dart';

class FinancesPage extends GetWidget<FinancesController> {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const AppLogo(size: 35),
        centerTitle: false,
        actions: [
          _settingsMenuButton(context),
        ],
      ),
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.settings),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
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
                        value: controller.appController.canEnableBiometrics
                            ? controller.appController.isBiometricsEnabled
                            : false,
                        onChanged: controller.appController.canEnableBiometrics
                            ? controller.appController.setIsBiometricsEnabled
                            : null,
                        title: Text('enable-biometrics-button'.i18n()),
                        subtitle: controller.appController.canEnableBiometrics
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
                    onTap: controller.appController.logout,
                    trailing: const Icon(Icons.exit_to_app),
                    iconColor: Colors.red,
                    title: Text('logout-button'.i18n()),
                    textColor: Colors.red,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
