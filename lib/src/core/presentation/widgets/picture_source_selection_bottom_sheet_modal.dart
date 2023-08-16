import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/bottom_sheet_modal_widget.dart';

class PictureSourceSelectionBottomSheetModal extends StatelessWidget {
  final void Function() onTapCamera;
  final void Function() onTapGallery;

  const PictureSourceSelectionBottomSheetModal({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getIconTile(
            icon: CupertinoIcons.camera,
            text: 'image-source-camera-text'.i18n(),
            color: Colors.grey[600]!,
            onTap: onTapCamera,
          ),
          const Divider(),
          _getIconTile(
            icon: CupertinoIcons.photo,
            text: 'image-source-gallery-text'.i18n(),
            color: Colors.grey[600]!,
            onTap: onTapGallery,
          ),
        ],
      ),
    );
  }

  Widget _getIconTile({
    required IconData icon,
    required String text,
    required Color color,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: color,
                size: 40,
              ),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
                textScaleFactor: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
