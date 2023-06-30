import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/presentation/widgets/app_logo.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    AppLogo(verticalAlign: false),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('next-button'.i18n()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
