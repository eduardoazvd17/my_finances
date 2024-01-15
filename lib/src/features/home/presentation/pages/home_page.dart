import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/views/settings_bottom_sheet_modal.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../../../core/presentation/widgets/scaffold_widget.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../../../../core/presentation/widgets/profile_picture_widget.dart';
import '../controllers/home_controller.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      hideDesktopLogo: true,
      appBar: _getAppBar(context),
      body: Container(),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      title: ResponsiveBuilder(
        desktopWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfilePictureWidget(
                  size: 80,
                  url: AppController.instance.user?.photoUrl,
                  onTap: controller.goToMyProfilePage,
                  tooltip: 'my-profile-button'.i18n(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'hello-text'.i18n(
                      [AppController.instance.user!.nickname],
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            _settingsMenuButton(context)
          ],
        ),
        mobileWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfilePictureWidget(
                  size: 50,
                  url: AppController.instance.user?.photoUrl,
                  onTap: controller.goToMyProfilePage,
                  tooltip: 'my-profile-button'.i18n(),
                ),
                _settingsMenuButton(context)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'hello-text'.i18n([AppController.instance.user!.nickname]),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButtonWidget(
      tooltip: 'settings-text'.i18n(),
      icon: CupertinoIcons.settings,
      compactMode: true,
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => const SettingsBottomSheetModal(),
      ),
    );
  }
}
