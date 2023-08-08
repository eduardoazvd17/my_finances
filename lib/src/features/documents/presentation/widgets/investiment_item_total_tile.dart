import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text('$quotas ${CurrencyUtils.format(quotasValue)}'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${OperationType.buy.char} $purchasesQuotas ${CurrencyUtils.format(purchasesValue)}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              Flexible(
                child: Text(
                  '${OperationType.sell.char} $salesQuotas ${CurrencyUtils.format(salesValue)}',
                  style: TextStyle(color: Colors.red[200]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
