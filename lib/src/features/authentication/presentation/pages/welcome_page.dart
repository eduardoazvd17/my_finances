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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(
                verticalAlign: true,
                size: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'welcome-text'.i18n(),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'slogan-text'.i18n(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.25),
                          ),
                        ),
                        child: Text('login-button-text'.i18n()),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('register-button-text'.i18n()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
