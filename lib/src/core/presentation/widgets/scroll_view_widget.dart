import 'package:flutter/material.dart';

class ScrollViewWidget extends StatelessWidget {
  final Widget child;
  final bool showBar;
  late final ScrollController scrollController;

  ScrollViewWidget({
    super.key,
    required this.child,
    this.showBar = false,
    ScrollController? controller,
  }) {
    scrollController = controller ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (showBar) {
      return Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 2,
        child: SingleChildScrollView(
          controller: scrollController,
          child: child,
        ),
      );
    } else {
      return SingleChildScrollView(
        controller: scrollController,
        child: child,
      );
    }
  }
}
