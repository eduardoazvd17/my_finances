import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/currency_utils.dart';
import '../../data/enums/operation_type.dart';

class InvestimentItemTotalTile extends StatelessWidget {
  final String title;
  final double purchasesValue;
  final int purchasesQuotas;
  final double salesValue;
  final int salesQuotas;
  final double quotasValue;
  final int quotas;
  const InvestimentItemTotalTile({
    super.key,
    required this.title,
    required this.purchasesValue,
    required this.purchasesQuotas,
    required this.salesValue,
    required this.salesQuotas,
    required this.quotasValue,
    required this.quotas,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '${OperationType.buy.title}s: ${CurrencyUtils.format(purchasesValue)}',
          ),
          Text(
            '${OperationType.sell.title}s: ${CurrencyUtils.format(salesValue)}',
          ),
          Text('${'quota-text'.i18n()}: $quotas'),
        ],
      ),
    );
  }
}
