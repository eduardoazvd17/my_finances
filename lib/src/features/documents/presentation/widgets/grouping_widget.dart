import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfinances/src/features/documents/data/enums/document_type.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_tile_widget.dart';

import '../../data/models/grouping_model.dart';
import '../../data/models/item_model.dart';

class GroupingWidget extends StatelessWidget {
  final GroupingModel groupingModel;
  final DocumentType documentType;
  final List<ItemModel> items;

  const GroupingWidget({
    super.key,
    required this.groupingModel,
    required this.documentType,
    required this.items,
  });

  GroupingWidgetController get _controller => groupingModel.getController();

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Obx(
                      () => InkWell(
                        borderRadius: BorderRadius.circular(10),
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
                        Text(groupingModel.title),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (_controller.isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items.map((item) {
                        return ItemTileWidget(
                          item: item,
                          documentType: documentType,
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class GroupingWidgetController extends GetxController {
  GroupingWidgetController({bool initializeExpanded = false}) {
    _isExpanded = RxBool(initializeExpanded);
  }

  late final RxBool _isExpanded;
  bool get isExpanded => _isExpanded.value;
  void toggleIsExpanded() => _isExpanded.value = !isExpanded;
}
