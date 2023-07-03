import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../controllers/app_controller.dart';
import '../widgets/app_logo.dart';
import '../widgets/button_widget.dart';

class AuthOverlayView extends StatelessWidget {
  const AuthOverlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: AppLogo(verticalAlign: true),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          text: 'cancel-button'.i18n(),
                          borderColor: Colors.transparent,
                          onTap: AppController.instance.logout,
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
    );
  }
}
