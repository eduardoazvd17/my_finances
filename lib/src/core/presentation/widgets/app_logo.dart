import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool verticalAlign;
  final bool showText;
  final bool showIcon;

  const AppLogo({
    super.key,
    this.size = 50,
    this.verticalAlign = false,
    this.showIcon = true,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
      if (showIcon) Icon(CupertinoIcons.money_dollar_circle, size: size),
      if (showIcon && showText)
        SizedBox(
          height: verticalAlign ? (size / 8) : 0,
          width: verticalAlign ? 0 : (size / 8),
        ),
      if (showText)
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
