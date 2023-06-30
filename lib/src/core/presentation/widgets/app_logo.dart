import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(CupertinoIcons.money_dollar_circle),
        const SizedBox(width: 5),
        Text(
          'app-name'.i18n(),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
