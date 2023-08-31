import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_modal_widget.dart';

class BottomSheetModalPicker<T> extends StatelessWidget {
  final List<Widget> itemsWidget;
  final int selectedIndex;
  final void Function(int) onChange;
  const BottomSheetModalPicker({
    super.key,
    required this.itemsWidget,
    required this.selectedIndex,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetModalWidget(
      child: Column(
        children: [
          const Divider(),
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              squeeze: 1,
              itemExtent: 40,
              useMagnifier: true,
              magnification: 1.22,
              scrollController: FixedExtentScrollController(
                initialItem: selectedIndex,
              ),
              onSelectedItemChanged: onChange,
              children: itemsWidget,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
