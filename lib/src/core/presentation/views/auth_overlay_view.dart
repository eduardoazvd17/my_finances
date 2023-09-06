import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../controllers/app_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_dialog.dart';

class AuthOverlayView extends StatefulWidget {
  const AuthOverlayView({super.key});

  @override
  State<AuthOverlayView> createState() => _AuthOverlayViewState();
}

class _AuthOverlayViewState extends State<AuthOverlayView> {
  bool _autoClose = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      OnResumeEventHandler(
        onResume: () {
          if (_autoClose) {
            AppController.instance.closeAuthOverlay();
            setState(() => _autoClose = false);
          }
        },
        onPause: () {
          setState(() => _autoClose = true);
        },
      ),
    );
  }

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
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                              icon: CupertinoIcons.lock_open,
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
                              icon: Icons.exit_to_app,
                              text: 'logout-button'.i18n(),
                              foregroundColor: Colors.red[300],
                              borderColor: Colors.red[300],
                              onTap: () {
                                Get.dialog(
                                  CustomDialog(
                                    title: 'logout-button'.i18n(),
                                    content: 'logout-confirmation-text'.i18n(),
                                    onConfirm: AppController.instance.logout,
                                    invertButtonColor: true,
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

class OnResumeEventHandler extends WidgetsBindingObserver {
  final void Function() onResume;
  final void Function() onPause;

  OnResumeEventHandler({
    required this.onResume,
    required this.onPause,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      onResume.call();
    }
    if (state == AppLifecycleState.paused) {
      onPause.call();
    }
  }
}
