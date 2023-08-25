import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/errors/app_error.dart';

import '../../../../core/data/utils/app_themes.dart';

class MyProfilePicturePage extends StatelessWidget {
  const MyProfilePicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        title: Text(
          'profile-picture-text'.i18n(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InteractiveViewer(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppThemes.commonColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Image.network(
                          Get.arguments?.toString() ?? '',
                          errorBuilder: (_, __, ___) {
                            return Text(
                              AppError.generic().message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
