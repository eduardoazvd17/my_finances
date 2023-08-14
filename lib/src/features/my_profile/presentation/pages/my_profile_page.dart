import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';

import 'package:myfinances/src/features/my_profile/presentation/controllers/my_profile_controller.dart';

import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/profile_picture_widget.dart';

class MyProfilePage extends GetWidget<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('my-profile-button'.i18n()),
        actions: [_logoutButton(onlyIcon: true)],
      ),
      body: ScrollViewWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePictureWidget(url: controller.photoUrl),
                    const SizedBox(width: 16),
                    Column(
                      children: controller.photoUrl == null
                          ? [
                              TextButton(
                                onPressed: () {},
                                child: Text('add-photo-button'.i18n()),
                              ),
                            ]
                          : [
                              TextButton(
                                onPressed: () {},
                                child: Text('edit-photo-button'.i18n()),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('remove-photo-button'.i18n()),
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => itemTile(
                label: 'name-text'.i18n(),
                content: controller.name,
                trailing: IconButton(
                  onPressed: () {},
                  tooltip: 'edit-text'.i18n(),
                  icon: const Icon(CupertinoIcons.pen),
                ),
              ),
            ),
            Obx(
              () => itemTile(
                label: 'nickname-text'.i18n(),
                content: controller.nickname,
                trailing: IconButton(
                  onPressed: () {},
                  tooltip: 'edit-text'.i18n(),
                  icon: const Icon(CupertinoIcons.pen),
                ),
              ),
            ),
            itemTile(
              label: 'email-text'.i18n(),
              content: controller.email,
            ),
            itemTile(
              label: 'password-text'.i18n(),
              content: '••••••••',
              trailing: TextButton(
                onPressed: controller.goToChangePasswordPage,
                child: Text('change-password-button'.i18n()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: _logoutButton()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: _deleteAccountButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemTile({
    required String label,
    required String content,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: trailing != null ? 0 : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(content)),
                    if (trailing != null) trailing
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _logoutButton({bool onlyIcon = false}) {
    void logout() {
      Get.dialog(
        CustomDialog(
          title: 'logout-button'.i18n(),
          content: 'logout-confirmation-text'.i18n(),
          onConfirm: AppController.instance.logout,
          invertButtonColor: true,
        ),
        barrierColor: Colors.black87,
      );
    }

    if (onlyIcon) {
      return IconButton(
        onPressed: logout,
        tooltip: 'logout-button'.i18n(),
        icon: Icon(Icons.exit_to_app, color: Colors.red[200]),
      );
    } else {
      return InkWell(
        onTap: logout,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'logout-button'.i18n(),
            style: TextStyle(color: Colors.red[200]),
          ),
        ),
      );
    }
  }

  Widget _deleteAccountButton() {
    return InkWell(
      onTap: () {
        Get.dialog(
          CustomDialog(
            title: 'delete-account-button'.i18n(),
            content: 'delete-account-confirmation-text'.i18n(),
            onConfirm: controller.deleteAccount,
            invertButtonColor: true,
          ),
          barrierColor: Colors.black87,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'delete-account-button'.i18n(),
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
