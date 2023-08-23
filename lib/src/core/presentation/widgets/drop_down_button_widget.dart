import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../data/utils/app_themes.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  final T value;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final double iconSize;
  final double? itemHeight;
  final FocusNode? focusNode;
  final bool isExpanded;
  final String? hintText;
  final double borderRadius;
  const DropDownButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.iconSize = 20,
    this.isExpanded = false,
    this.itemHeight,
    this.focusNode,
    this.hintText,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: DropdownButton<T>(
          isExpanded: true,
          iconSize: iconSize,
          iconEnabledColor: Theme.of(context).primaryColor,
          iconDisabledColor: AppThemes.commonColor,
          elevation: 24,
          underline: const SizedBox(),
          icon: const Icon(CupertinoIcons.chevron_down),
          borderRadius: BorderRadius.circular(borderRadius),
          itemHeight: itemHeight,
          focusNode: focusNode,
          value: value,
          items: items,
          onChanged: onChanged,
          hint: Text(hintText ?? 'select-text'.i18n()),
          padding: const EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }
}
