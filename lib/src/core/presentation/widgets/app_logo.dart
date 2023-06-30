import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool verticalAlign;

  const AppLogo({
    super.key,
    this.size = 40,
    this.verticalAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      Icon(CupertinoIcons.money_dollar_circle, size: size),
      SizedBox(
        height: verticalAlign ? (size / 8) : 0,
        width: verticalAlign ? 0 : (size / 8),
      ),
      Text(
        'app-name'.i18n(),
        style: TextStyle(fontSize: size / 2),
      ),
    ];

    if (verticalAlign) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: content,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: content,
      );
    }
  }
}
