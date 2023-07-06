import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String tooltip;
  final bool compactMode;
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
