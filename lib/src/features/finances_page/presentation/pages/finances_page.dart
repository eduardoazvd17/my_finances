import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';
import 'package:myfinances/src/core/presentation/widgets/scaffold_widget.dart';

import '../controllers/finances_controller.dart';

class FinancesPage extends GetWidget<FinancesController> {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('app-name'.i18n()),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: AppLogo(showText: false, size: 70),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Olá, Eduardo Azevedo.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(),
                  SwitchListTile(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.green,
                    title: Text('Solicitar biometria'),
                  ),
                ],
              ),
              ListTile(
                onTap: controller.appController.logout,
                title: Text(
                  'Finalizar sessão',
                  style: TextStyle(color: Colors.red),
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
      body: Text('logado!'),
    );
  }
}
