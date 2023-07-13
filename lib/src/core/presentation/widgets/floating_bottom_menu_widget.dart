import 'package:flutter/material.dart';
import 'package:myfinances/src/core/presentation/widgets/scroll_view_widget.dart';

class FloatingBottomMenuWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final List<FloatingBottomMenuItem> items;
  const FloatingBottomMenuWidget({
    super.key,
    required this.items,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: ScrollViewWidget(
            showBar: true,
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: items,
              ),
            ),
          ),
        ),
      ),
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
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
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
