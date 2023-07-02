import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Drawer? drawer;
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.body,
    this.drawer,
  });

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: body,
          ),
        ),
      ),
    );
  }
}
