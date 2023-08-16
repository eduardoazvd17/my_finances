import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double borderRadius;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isDisabled;

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
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      highlightColor: Colors.grey.withOpacity(0.25),
      borderRadius: BorderRadius.circular(borderRadius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDisabled ? Colors.transparent : backgroundColor,
          border: Border.all(
            color: isDisabled
                ? Colors.grey[600]!
                : (borderColor ?? Theme.of(context).primaryColor),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    icon,
                    color: isDisabled
                        ? Colors.grey[600]!
                        : (foregroundColor ?? Theme.of(context).primaryColor),
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isDisabled
                        ? Colors.grey[600]!
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
