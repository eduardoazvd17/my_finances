import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  final bool inline;

  const LoadingWidget({
    this.text = "Carregando...",
    this.inline = false,
    super.key,
  });

  static dialog() {
    Get.dialog(
      Center(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: LoadingWidget(),
          ),
        ),
      ),
      barrierDismissible: false,
      name: 'loading',
    );
  }

  Widget _progressWidget(BuildContext context) {
    return CircularProgressIndicator(color: Theme.of(context).primaryColor)
        .animate()
        .fade()
        .slideY();
  }

  Widget _textWidget(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ).animate().fade();
  }

  @override
  Widget build(BuildContext context) {
    if (inline) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _progressWidget(context),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: _textWidget(context),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _progressWidget(context),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: _textWidget(context),
          ),
        ],
      );
    }
  }
}
