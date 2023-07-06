import 'package:flutter/material.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  final T value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final double? itemHeight;
  final FocusNode? focusNode;
  final bool isExpanded;
  const DropDownButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.isExpanded = false,
    this.itemHeight,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: true,
      iconSize: 35,
      iconEnabledColor: Theme.of(context).primaryColor,
      iconDisabledColor: Colors.grey[600],
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      itemHeight: itemHeight,
      focusNode: focusNode,
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
