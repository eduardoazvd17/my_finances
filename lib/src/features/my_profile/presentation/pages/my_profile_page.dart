import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';

import 'package:myfinances/src/features/my_profile/presentation/controllers/my_profile_controller.dart';

class MyProfilePage extends GetWidget<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(title: Text('my-profile-button'.i18n())),
      body: ScrollViewWidget(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Theme.of(context).primaryColor,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(CupertinoIcons.person,
                          size: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
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
}
