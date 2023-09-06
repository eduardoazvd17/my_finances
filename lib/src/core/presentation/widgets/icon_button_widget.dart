import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final void Function()? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double iconSize;
  final bool useScaleFactor;
  final bool compactMode;
  const IconButtonWidget({
    super.key,
    required this.icon,
    this.tooltip = '',
    this.iconSize = 26,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius = 10,
    this.useScaleFactor = false,
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
                size: useScaleFactor
                    ? (iconSize * MediaQuery.of(context).textScaleFactor)
                    : iconSize,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
