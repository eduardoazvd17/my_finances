import 'package:flutter/material.dart';

class BottomSheetModalWidget extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  const BottomSheetModalWidget({
    super.key,
    required this.child,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 8,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[600],
                ),
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(icon),
                      ),
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }
}
