import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

class LoadingWidget extends StatelessWidget {
  final String? text;
  final bool inline;
  final bool removeLogo;

  const LoadingWidget({
    this.text,
    this.inline = false,
    this.removeLogo = false,
    super.key,
  });

  static dialog({bool removeLogo = false}) {
    Get.dialog(
      Center(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: LoadingWidget(removeLogo: removeLogo),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black87,
    );
  }

  Widget _progressWidget(BuildContext context) {
    const size = 70.0;
    return Stack(
      children: [
        if (!removeLogo)
          SizedBox(
            height: size,
            width: size,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/logo.png").animate().fade(),
            ),
          ),
        SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 6,
          ),
        ),
      ],
    );
  }

  Widget _textWidget(BuildContext context) {
    return Text(
      text ?? 'loading-text'.i18n(),
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
            padding: const EdgeInsets.only(left: 20.0),
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
            padding: const EdgeInsets.only(top: 20.0),
            child: _textWidget(context),
          ),
        ],
      );
    }
  }
}
