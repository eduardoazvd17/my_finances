import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'button_widget.dart';

import '../../data/utils/app_themes.dart';

class AdviseMessageWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? description;
  final String? actionButtonText;
  final IconData? actionButtonIcon;
  final void Function()? onAction;

  const AdviseMessageWidget({
    super.key,
    required this.icon,
    required this.message,
    this.description,
    this.actionButtonText,
    this.actionButtonIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 35)
              .animate()
              .fade()
              .slideY(),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ).animate().fade(),
          if (description != null)
            Text(
              description!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppThemes.commonColor),
            ).animate().fade(),
          if (onAction != null && actionButtonText != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ButtonWidget(
                text: actionButtonText!,
                onTap: onAction!,
                icon: actionButtonIcon,
              ),
            ),
        ],
      ),
    );
  }
}
