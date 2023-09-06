import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../core/presentation/widgets/button_widget.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';
import '../../../../core/presentation/widgets/scroll_view_widget.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
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
                    return const LoadingWidget();
                  } else {
                    return _getLoginAndRegisterButtons(context);
                  }
                },
              ),
              Obx(() => _appVersionWidget()),
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
            style: const TextStyle(color: AppThemes.commonColor),
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
                  icon: CupertinoIcons.lock_open,
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
                  icon: Icons.exit_to_app,
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
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButtonWidget(
        icon: CupertinoIcons.settings,
        tooltip: 'settings-text'.i18n(),
        onTap: () => showModalBottomSheet(
          context: context,
          useSafeArea: true,
          builder: (_) => const SettingsBottomSheetModal(),
        ),
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
                  icon: CupertinoIcons.person,
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
                  icon: CupertinoIcons.person_add,
                  text: 'register-button'.i18n(),
                  onTap: controller.goToRegisterPage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _appVersionWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Text(
        AppController.instance.appVersion,
        style: const TextStyle(
          color: AppThemes.commonColor,
        ),
      ),
    );
  }
}
