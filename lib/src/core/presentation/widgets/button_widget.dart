import 'package:flutter/material.dart';

import '../../data/utils/app_themes.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double borderRadius;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isDisabled;
  final void Function()? onTapDisabled;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius = 10,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.isDisabled = false,
    this.onTapDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? onTapDisabled : onTap,
      highlightColor: Colors.grey.withOpacity(0.25),
      borderRadius: BorderRadius.circular(borderRadius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDisabled ? Colors.transparent : backgroundColor,
          border: Border.all(
            color: isDisabled
                ? AppThemes.commonColor
                : (borderColor ?? Theme.of(context).primaryColor),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    icon,
                    color: isDisabled
                        ? AppThemes.commonColor
                        : (foregroundColor ?? Theme.of(context).primaryColor),
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isDisabled
                        ? AppThemes.commonColor
                        : (foregroundColor ?? Theme.of(context).primaryColor),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
