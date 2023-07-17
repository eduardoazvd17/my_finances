import 'package:flutter/material.dart';

import '../../../../core/data/utils/currency_utils.dart';
import '../../data/models/item_model.dart';
import '../../data/enums/document_type.dart';

class ItemTileWidget extends StatelessWidget {
  final ItemModel item;
  final DocumentType documentType;

  const ItemTileWidget({
    super.key,
    required this.item,
    required this.documentType,
  });

  @override
  Widget build(BuildContext context) {
    return switch (documentType) {
      DocumentType.monthlyExpenseControl => _monthlyExpenseControlItemTile(
          context,
        ),
      DocumentType.investmentControl => _investmentControlItemTile(
          context,
        ),
      DocumentType.annotation => _annotationItemTile(
          context,
        ),
      DocumentType.pointsAndAirlineMiles => _pointsAndAirlineMilesItemTile(
          context,
        ),
    };
  }

  Widget _monthlyExpenseControlItemTile(BuildContext context) {
    //final MonthlyExpenseControlItemModel item = this.item as MonthlyExpenseControlItemModel;
    return Container();
  }

  Widget _investmentControlItemTile(BuildContext context) {
    //final InvestimentControlItemModel item = this.item as InvestimentControlItemModel;
    return Container();
  }

  Widget _annotationItemTile(BuildContext context) {
    final AnnotationItemModel item = this.item as AnnotationItemModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.quantity != null)
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                '${item.quantity}x',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          Expanded(child: Text(item.name)),
          if (item.price != null)
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                CurrencyUtils.format(item.price!),
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pointsAndAirlineMilesItemTile(BuildContext context) {
    //final PointsAndAirlineMilesItemModel item = this.item as PointsAndAirlineMilesItemModel;
    return Container();
  }
}
