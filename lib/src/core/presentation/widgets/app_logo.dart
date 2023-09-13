import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final double opacity;
  final bool verticalAlign;
  final bool hideText;

  // ignore: prefer_const_constructors_in_immutables
  AppLogo({
    super.key,
    this.size = 50,
    this.opacity = 1.0,
    this.verticalAlign = false,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      Image.asset(
        'assets/images/logo.png',
        height: size,
        opacity: AlwaysStoppedAnimation(opacity),
      ),
      if (!hideText)
        SizedBox(
          height: verticalAlign ? (size / 4) : 0,
          width: verticalAlign ? 0 : (size / 4),
        ),
      if (!hideText)
        Opacity(
          opacity: opacity,
          child: Text(
            'app-name'.i18n(),
            style: TextStyle(fontSize: size / 2),
          ),
        ),
    ];

    if (verticalAlign) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}
