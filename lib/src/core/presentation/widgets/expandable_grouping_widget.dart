import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableGroupingWidget extends StatelessWidget {
  late final ExpandableGroupingWidgetController _controller;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;

  ExpandableGroupingWidget({
    super.key,
    ExpandableGroupingWidgetController? controller,
    required this.title,
    this.subtitle,
    this.icon,
    required this.child,
  }) {
    _controller = controller ?? ExpandableGroupingWidgetController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 350),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => InkWell(
                    onTap: _controller.toggleIsExpanded,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        _controller.isExpanded
                            ? CupertinoIcons.chevron_down
                            : CupertinoIcons.chevron_right,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              )),
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Icon(icon),
                ),
            ],
          ),
          Obx(() => _controller.isExpanded
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: child,
                )
              : Container()),
          const Divider(),
        ],
      ),
    );
  }
}

class ExpandableGroupingWidgetController extends GetxController {
  ExpandableGroupingWidgetController({
    bool initializeExpanded = false,
  }) {
    _isExpanded = RxBool(initializeExpanded);
  }

  late final RxBool _isExpanded;
  bool get isExpanded => _isExpanded.value;
  void toggleIsExpanded() => _isExpanded.value = !isExpanded;
}
