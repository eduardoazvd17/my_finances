import 'package:flutter/material.dart';

class FloatingBottomMenuWidget extends StatelessWidget {
  final List<FloatingBottomMenuItem> items;
  const FloatingBottomMenuWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      elevation: 8,
      child: Wrap(children: items),
    );
  }
}

class FloatingBottomMenuItem extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String tooltip;
  final bool showTooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  const FloatingBottomMenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.showTooltip = false,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      verticalOffset: 35,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: foregroundColor),
                ),
              ),
              if (showTooltip)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    tooltip,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
