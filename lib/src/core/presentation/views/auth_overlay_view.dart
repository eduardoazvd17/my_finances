import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../controllers/app_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_dialog.dart';

class AuthOverlayView extends StatelessWidget {
  const AuthOverlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: [
                      const Icon(CupertinoIcons.lock, size: 100),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'auth-required-text'.i18n(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              icon: const Icon(
                                CupertinoIcons.lock_open,
                                color: Colors.white,
                              ),
                              text: 'unlock-button'.i18n(),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              onTap: AppController.instance.closeAuthOverlay,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              text: 'logout-button'.i18n(),
                              borderColor: Colors.transparent,
                              onTap: () {
                                Get.dialog(
                                  CustomDialog(
                                    title: 'logout-button'.i18n(),
                                    content: 'logout-confirmation-text'.i18n(),
                                    onConfirm: AppController.instance.logout,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
