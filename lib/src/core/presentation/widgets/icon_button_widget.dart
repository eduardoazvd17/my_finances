import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String tooltip;
  final void Function()? onTap;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final Color? borderColor;
  final double borderRadius;
  final Color? backgroundColor;
  final bool compactMode;
  const IconButtonWidget({
    super.key,
    this.tooltip = '',
    this.onTap,
    required this.icon,
    this.iconSize = 26,
    this.iconColor,
    this.borderColor,
    this.borderRadius = 10,
    this.backgroundColor,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(compactMode ? 0 : 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? Colors.transparent,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
