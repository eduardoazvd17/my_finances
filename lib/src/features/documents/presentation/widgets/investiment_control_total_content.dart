import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../data/enums/operation_type.dart';
import '../../data/models/grouping_model.dart';
import '../../data/models/item_model.dart';
import 'investiment_item_total_tile.dart';
import 'item_total_tile.dart';

class InvestimentControlTotalContent extends StatelessWidget {
  final List<GroupingModel> groups;
  final List<InvestimentControlItemModel> items;
  const InvestimentControlTotalContent({
    super.key,
    required this.groups,
    required this.items,
  });

  Iterable<InvestimentControlItemModel> get purchaseItems =>
      items.where((e) => e.operationType == OperationType.purchase);

  Iterable<InvestimentControlItemModel> get sellItems =>
      items.where((e) => e.operationType == OperationType.sell);

  Iterable<InvestimentControlItemModel> itemsByGroup(String groupingId) {
    return items.where((e) => e.groupingId == groupingId);
  }

  Iterable<InvestimentControlItemModel> purchaseItemsByGroup(
    String groupingId,
  ) {
    return items.where((e) =>
        e.operationType == OperationType.purchase &&
        e.groupingId == groupingId);
  }

  Iterable<InvestimentControlItemModel> sellItemsByGroup(
    String groupingId,
  ) {
    return items.where((e) =>
        e.operationType == OperationType.sell && e.groupingId == groupingId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        ItemTotalTile(
          title: 'total-buys-label'.i18n(),
          price: purchaseItems.isEmpty
              ? 0
              : purchaseItems
                  .map((i) => i.quantity * i.price)
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: null,
          priceColor: Colors.green,
        ),
        ItemTotalTile(
          title: 'total-sales-label'.i18n(),
          price: sellItems.isEmpty
              ? 0
              : sellItems
                  .map((i) => i.quantity * i.price)
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: null,
          priceColor: Colors.red[300]!,
        ),
        ItemTotalTile(
          title: 'profit-label'.i18n(),
          price: items.isEmpty
              ? 0
              : items
                  .map((i) {
                    if (i.operationType == OperationType.purchase) {
                      return -(i.quantity * i.price);
                    } else {
                      return (i.quantity * i.price);
                    }
                  })
                  .reduce((a, b) => a + b)
                  .toDouble(),
          quantity: null,
          priceColor: Theme.of(context).primaryColor,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Center(
            child: Text(
              'resume-by-asset-text'.i18n(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ...groups.map((g) {
          if (itemsByGroup(g.id).isEmpty) {
            return Container();
          } else {
            return InvestimentItemTotalTile(
              title: g.name,
              purchasesValue: purchaseItemsByGroup(g.id).isEmpty
                  ? 0
                  : purchaseItemsByGroup(g.id)
                      .map((i) => i.quantity * i.price)
                      .reduce((a, b) => a + b),
              purchasesQuotas: purchaseItemsByGroup(g.id).isEmpty
                  ? 0
                  : purchaseItemsByGroup(g.id)
                      .map((i) => i.quantity)
                      .reduce((a, b) => a + b),
              salesValue: sellItemsByGroup(g.id).isEmpty
                  ? 0
                  : sellItemsByGroup(g.id)
                      .map((i) => i.quantity * i.price)
                      .reduce((a, b) => a + b),
              salesQuotas: sellItemsByGroup(g.id).isEmpty
                  ? 0
                  : sellItemsByGroup(g.id)
                      .map((i) => i.quantity)
                      .reduce((a, b) => a + b),
              quotasValue: purchaseItemsByGroup(g.id).isEmpty &&
                      sellItemsByGroup(g.id).isEmpty
                  ? 0
                  : itemsByGroup(g.id)
                      .map((e) => switch (e.operationType) {
                            OperationType.purchase => -(e.quantity * e.price),
                            OperationType.sell => e.quantity * e.price,
                          })
                      .reduce((a, b) => a + b),
              quotas: purchaseItemsByGroup(g.id).isEmpty &&
                      sellItemsByGroup(g.id).isEmpty
                  ? 0
                  : itemsByGroup(g.id)
                      .map((e) => switch (e.operationType) {
                            OperationType.purchase => e.quantity,
                            OperationType.sell => -e.quantity,
                          })
                      .reduce((a, b) => a + b),
            );
          }
        }),
      ],
    );
  }
}
