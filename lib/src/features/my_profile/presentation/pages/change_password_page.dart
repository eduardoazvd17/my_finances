import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text('change-password-button'.i18n()),
      ),
    );
  }
}
