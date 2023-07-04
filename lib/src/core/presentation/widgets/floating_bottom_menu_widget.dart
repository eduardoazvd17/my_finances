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
  final Color? iconColor;
  final String? tooltip;
  const FloatingBottomMenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      verticalOffset: 35,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          height: 50,
          width: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}
