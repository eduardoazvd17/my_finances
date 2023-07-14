import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final bool centerTitle;
  final String? content;
  final bool centerContent;
  final Widget? child;
  final String? confirmButtonText;
  final void Function()? onConfirm;
  final String? closeButtonText;
  final void Function()? onClose;
  final bool autoClose;
  final bool invertButtonColor;

  const CustomDialog({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.content,
    this.centerContent = true,
    this.child,
    this.confirmButtonText,
    this.onConfirm,
    this.closeButtonText,
    this.onClose,
    this.autoClose = true,
    this.invertButtonColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: centerTitle
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 2, color: Colors.grey[100]!, height: 5),
          if (content != null && child == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(content!, textAlign: TextAlign.center),
            ),
          if (child != null && content == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: child!,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (onConfirm != null) ...[
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        onConfirm?.call();
                        if (autoClose) Get.close(1);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: invertButtonColor
                              ? Colors.red[300]
                              : Theme.of(context).primaryColor.withAlpha(180),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            confirmButtonText ?? 'yes-button'.i18n(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                ],
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      bottomLeft: onConfirm == null
                          ? const Radius.circular(20)
                          : Radius.zero,
                      bottomRight: const Radius.circular(20),
                    ),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      onClose?.call();
                      if (autoClose) Get.close(1);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: onConfirm == null
                            ? Theme.of(context).primaryColor.withAlpha(180)
                            : invertButtonColor
                                ? Theme.of(context).primaryColor.withAlpha(180)
                                : Colors.red[300],
                        borderRadius: BorderRadius.only(
                          bottomLeft: onConfirm == null
                              ? const Radius.circular(20)
                              : Radius.zero,
                          bottomRight: const Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          onConfirm == null
                              ? 'close-button'.i18n()
                              : closeButtonText ?? 'no-button'.i18n(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
