import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/core/presentation/views/settings_view.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

import '../controllers/documents_controller.dart';

class DocumentsPage extends GetWidget<DocumentsController> {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: const AppLogo(size: 35),
        centerTitle: false,
        actions: [
          _settingsMenuButton(context),
        ],
      ),
    );
  }

  Widget _settingsMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.settings),
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => const SettingsView(),
      ),
    );
  }
}
