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
      appBar: AppBar(title: Text('my-profile-button'.i18n())),
      body: ScrollViewWidget(
        child: Column(
          children: [
            const ProfilePictureWidget(),
            Obx(
              () => itemTile(
                label: 'name-text'.i18n(),
                content: controller.name,
              ),
            ),
            itemTile(
              label: 'email-text'.i18n(),
              content: controller.email,
            ),
            itemTile(
              label: 'password-text'.i18n(),
              content: '********',
            ),
            _logoutButton(),
          ],
        ),
      ),
    );
  }

  Widget itemTile({
    required String label,
    required String content,
    void Function()? onEdit,
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
              vertical: onEdit != null ? 0 : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(content)),
                    if (onEdit != null)
                      IconButton(
                        onPressed: onEdit,
                        tooltip: 'edit-text'.i18n(),
                        icon: const Icon(CupertinoIcons.pen),
                      ),
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

  Widget _logoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          Get.dialog(
            CustomDialog(
              title: 'logout-button'.i18n(),
              content: 'logout-confirmation-text'.i18n(),
              onConfirm: AppController.instance.logout,
              invertButtonColor: true,
            ),
            barrierColor: Colors.black87,
          );
        },
        trailing: const Icon(Icons.exit_to_app),
        iconColor: Colors.red,
        title: Text('logout-button'.i18n()),
        textColor: Colors.red,
      ),
    );
  }
}
