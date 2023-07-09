import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  final T value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final double iconSize;
  final double? itemHeight;
  final FocusNode? focusNode;
  final bool isExpanded;
  const DropDownButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.iconSize = 20,
    this.isExpanded = false,
    this.itemHeight,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: true,
      iconSize: iconSize,
      iconEnabledColor: Theme.of(context).primaryColor,
      iconDisabledColor: Colors.grey[600],
      elevation: 24,
      underline: Divider(
        height: 5,
        color: Theme.of(context).primaryColor,
      ),
      icon: const Icon(CupertinoIcons.chevron_down),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemHeight: itemHeight,
      focusNode: focusNode,
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
