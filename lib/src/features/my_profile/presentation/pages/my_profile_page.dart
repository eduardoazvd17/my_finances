import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';
import 'package:myfinances/src/features/my_profile/presentation/controllers/my_profile_controller.dart';

class MyProfilePage extends GetWidget<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('my-profile-button'.i18n()),
      ),
      body: Container(),
    );
  }
}
