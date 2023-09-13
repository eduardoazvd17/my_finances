import 'package:flutter/material.dart';

import 'app_logo.dart';
import 'responsive_builder.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingBottomMenu;
  final Widget? bottomNavigationMenu;
  final bool hideDesktopLogo;
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.body,
    this.floatingBottomMenu,
    this.bottomNavigationMenu,
    this.hideDesktopLogo = false,
  });

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: ResponsiveBuilder.maxDesktopWidth,
          ),
          child: GestureDetector(
            onTap: _hideKeyboard,
            child: Column(
              children: [
                if (!hideDesktopLogo)
                  ResponsiveBuilder(
                    desktopWidget: Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 5),
                      child: AppLogo(
                        size: 45,
                        opacity: 0.5,
                        hideText: true,
                      ),
                    ),
                  ),
                Expanded(
                  child: Scaffold(
                    appBar: appBar,
                    floatingActionButton: floatingBottomMenu,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    bottomNavigationBar: bottomNavigationMenu,
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: ResponsiveBuilder.contentMaxWidth,
                            ),
                            child: body,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
