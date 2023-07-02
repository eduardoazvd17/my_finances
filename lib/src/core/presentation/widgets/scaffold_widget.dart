import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.body,
  });

  void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        appBar: appBar,
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
