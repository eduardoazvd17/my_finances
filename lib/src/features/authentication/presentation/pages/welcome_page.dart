import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/button_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/loading_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';

import '../../../../core/presentation/views/settings_bottom_sheet_modal.dart';
import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../controllers/auth_controller.dart';

class WelcomePage extends GetWidget<AuthController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        actions: [
          _settingsMenuButton(context),
        ],
      ),
      body: Center(
        child: ScrollViewWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _welcomeWidget(),
              Obx(
                () {
                  if (controller.showBiometricsTryAgainButton) {
                    return _getBiometricsLoginForm(context);
                  } else if (controller.isLoading) {
                    return const LoadingWidget(
                      inline: false,
                      removeLogo: true,
                    );
                  } else {
                    return _getLoginAndRegisterButtons(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeWidget() {
    return Column(
      children: [
        AppLogo(verticalAlign: true),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'welcome-text'.i18n(),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Text(
            'slogan-text'.i18n(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        )
      ],
    );
  }

  Widget _getBiometricsLoginForm(BuildContext context) {
    return Column(
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
                  text: 'continue-as-button'.i18n([controller.lastUserName]),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onTap: controller.autoLogin,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  ),
                  text: 'logout-button'.i18n(),
                  borderColor: Colors.transparent,
                  onTap: () {
                    Get.dialog(
                      CustomDialog(
                        title: 'logout-button'.i18n(),
                        content: 'logout-confirmation-text'.i18n(),
                        onConfirm: controller.cancelAutoLogin,
                        invertButtonColor: true,
                      ),
                      barrierColor: Colors.black87,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.settings),
      onPressed: () => showModalBottomSheet(
        context: context,
        barrierColor: Colors.black87,
        useSafeArea: true,
        builder: (_) => const SettingsBottomSheetModal(),
      ),
    );
  }

  Widget _getLoginAndRegisterButtons(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  icon: const Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                  text: 'login-button'.i18n(),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onTap: controller.goToLoginPage,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  icon: Icon(
                    CupertinoIcons.person_add,
                    color: Theme.of(context).primaryColor,
                  ),
                  text: 'register-button'.i18n(),
                  onTap: controller.goToRegisterPage,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
