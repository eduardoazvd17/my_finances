import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_modal_widget.dart';

class BottomSheetModalPicker extends StatelessWidget {
  final Iterable<Widget> itemsWidget;
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
              itemExtent: 30 * MediaQuery.of(context).textScaleFactor,
              useMagnifier: true,
              magnification: 1.22,
              selectionOverlay: Stack(
                children: [
                  const CupertinoPickerDefaultSelectionOverlay(),
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              scrollController: FixedExtentScrollController(
                initialItem: selectedIndex,
              ),
              onSelectedItemChanged: onChange,
              children: itemsWidget
                  .map((e) => Padding(
                        padding: EdgeInsets.all(
                          4 * MediaQuery.of(context).textScaleFactor,
                        ),
                        child: FittedBox(
                          child: Center(
                            child: e,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
