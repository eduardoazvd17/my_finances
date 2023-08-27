import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/features/documents/data/models/grouping_model.dart';
import 'package:myfinances/src/features/documents/data/models/item_model.dart';
import 'package:myfinances/src/features/documents/presentation/widgets/item_total_tile.dart';

class AnnotationTotalContent extends StatelessWidget {
  final List<GroupingModel> groups;
  final List<AnnotationItemModel> items;

  const AnnotationTotalContent({
    super.key,
    required this.groups,
    required this.items,
  });

  Iterable<AnnotationItemModel> itemsByGroup(String groupingId) {
    return items.where((e) => e.groupingId == groupingId);
  }

  Iterable<AnnotationItemModel> get itemsWithoutGroup =>
      items.where((e) => e.groupingId == null);

  Iterable<AnnotationItemModel> get checkedItems =>
      items.where((e) => e.isChecked);

  Iterable<AnnotationItemModel> get uncheckedItems =>
      items.where((e) => !e.isChecked);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        ItemTotalTile(
          title: 'total-label'.i18n(),
          price: items.isEmpty
              ? 0
              : items
                  .map((i) {
                    return (i.quantity ?? 1) * (i.price ?? 0);
                  })
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: items.length,
        ),
        ItemTotalTile(
          title: 'checked-items'.i18n([
            checkedItems.length.toString(),
          ]),
          price: checkedItems.isEmpty
              ? 0
              : items
                  .where((i) => i.isChecked)
                  .map((i) {
                    return (i.quantity ?? 1) * (i.price ?? 0);
                  })
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: null,
        ),
        ItemTotalTile(
          title: 'unchecked-items'.i18n([
            uncheckedItems.length.toString(),
          ]),
          price: uncheckedItems.isEmpty
              ? 0
              : items
                  .where((i) => !i.isChecked)
                  .map((i) {
                    return (i.quantity ?? 1) * (i.price ?? 0);
                  })
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: null,
        ),
        const Divider(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'total-by-grouping-text'.i18n(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ...groups.map(
          (g) {
            if (itemsByGroup(g.id).isEmpty) {
              return Container();
            } else {
              final Iterable<double> itemsPrice = itemsByGroup(g.id).map((i) {
                return (i.quantity ?? 1) * (i.price ?? 0);
              });

              return ItemTotalTile(
                title: g.name,
                price: itemsPrice.isEmpty
                    ? 0
                    : itemsPrice.reduce((a, b) => a + b).toDouble(),
                quantity: itemsByGroup(g.id).length,
              );
            }
          },
        ),
        if (itemsWithoutGroup.isNotEmpty)
          ItemTotalTile(
            title: 'items-without-group'.i18n([
              itemsWithoutGroup.length.toString(),
            ]),
            price: itemsWithoutGroup
                .map((e) => e.price ?? 0)
                .reduce((a, b) => a + b)
                .toDouble(),
            quantity: null,
          ),
      ],
    );
  }
}
