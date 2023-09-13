import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final int maxMobileWidth;
  final Widget? mobileWidget;
  final Widget? desktopWidget;

  static const double maxDesktopWidth = 900;

  const ResponsiveBuilder({
    super.key,
    this.maxMobileWidth = 768,
    this.mobileWidget,
    this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, __) {
        if (MediaQuery.of(context).size.width >= maxMobileWidth) {
          return desktopWidget ?? const SizedBox();
        } else {
          return mobileWidget ?? const SizedBox();
        }
      },
    );
  }
}
