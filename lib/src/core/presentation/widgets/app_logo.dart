import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool verticalAlign;

  // ignore: prefer_const_constructors_in_immutables
  AppLogo({
    super.key,
    this.size = 50,
    this.verticalAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      Image.asset('assets/images/logo.png', height: size),
      SizedBox(
        height: verticalAlign ? (size / 4) : 0,
        width: verticalAlign ? 0 : (size / 4),
      ),
      Text(
        'app-name'.i18n(),
        style: TextStyle(fontSize: size / 2),
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
