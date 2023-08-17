import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/data/utils/currency_utils.dart';

class AnnotationItemTotalTile extends StatelessWidget {
  final String title;
  final double price;
  final int? quantity;
  const AnnotationItemTotalTile({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(title)),
              Text(
                CurrencyUtils.format(price),
                style: const TextStyle(color: Colors.lightGreen),
              ),
            ],
          ),
          if (quantity != null)
            Text(
              'items-quantity-text'.i18n([quantity.toString()]),
              style: TextStyle(color: AppThemes.commonColor),
            ),
        ],
      ),
    );
  }
}
