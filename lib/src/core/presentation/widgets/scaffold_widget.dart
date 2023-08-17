import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingBottomMenu;
  final Widget? bottomNavigationMenu;
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.body,
    this.floatingBottomMenu,
    this.bottomNavigationMenu,
  });

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: _hideKeyboard,
        child: Scaffold(
          appBar: appBar,
          floatingActionButton: floatingBottomMenu,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: bottomNavigationMenu,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
