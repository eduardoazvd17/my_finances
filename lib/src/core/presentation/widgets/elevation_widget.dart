import 'package:flutter/material.dart';

class ElevationWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  const ElevationWidget({
    super.key,
    required this.child,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );
  }
}
