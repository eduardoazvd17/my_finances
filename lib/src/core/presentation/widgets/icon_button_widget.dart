import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final void Function() onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final double borderRadius;
  const IconButtonWidget({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor ?? Theme.of(context).primaryColor,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: iconColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
