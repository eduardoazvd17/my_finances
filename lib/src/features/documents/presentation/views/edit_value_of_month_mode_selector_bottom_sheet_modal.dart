import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../../core/presentation/widgets/bottom_sheet_modal_widget.dart';
import '../../data/models/item_model.dart';
import '../controllers/document_editor_controller.dart';

class EditValueOfMonthModeSelectorBottomSheetModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final DocumentEditorController controller;
  final ItemModel itemModel;
  const EditValueOfMonthModeSelectorBottomSheetModal({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      icon: icon,
      title: title,
      child: Column(
        children: [
          _getIconTile(
            icon: CupertinoIcons.plus_circle,
            text: 'increment-value-button'.i18n(),
            color: Colors.green,
            onTap: () {},
          ),
          _getIconTile(
            icon: CupertinoIcons.pencil_circle,
            text: 'overwrite-value-button'.i18n(),
            color: Theme.of(context).primaryColor,
            onTap: () {},
          ),
          _getIconTile(
            icon: CupertinoIcons.minus_circle,
            text: 'decrement-value-button'.i18n(),
            color: Colors.red,
            onTap: () {},
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
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, color: color, size: 40),
            ),
            Expanded(child: Text(text, textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
