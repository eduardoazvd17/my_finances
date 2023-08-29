import 'package:flutter/material.dart';
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
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _tableWidget(context),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _tableWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: _getTableColumn(
            alignment: CrossAxisAlignment.center,
            label: 'Operation',
            first: OperationType.purchase.icon,
            second: OperationType.sell.icon,
            third: Text(
              'current-text'.i18n(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _verticalDivider(context),
        Flexible(
          child: _getTableColumn(
            alignment: CrossAxisAlignment.center,
            label: 'Quotas',
            first: Text(
              '$purchasesQuotas',
              style: const TextStyle(color: Colors.green),
            ),
            second: Text(
              '$salesQuotas',
              style: TextStyle(color: Colors.red[300]),
            ),
            third: Text('$quotas'),
          ),
        ),
        _verticalDivider(context),
        Flexible(
          child: _getTableColumn(
            alignment: CrossAxisAlignment.end,
            label: 'Value',
            first: Text(
              CurrencyUtils.format(purchasesValue),
              style: const TextStyle(color: Colors.green),
            ),
            second: Text(
              CurrencyUtils.format(salesValue),
              style: TextStyle(color: Colors.red[300]),
            ),
            third: Text(CurrencyUtils.format(quotasValue)),
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider(BuildContext context) {
    return Container(
      width: 0.5,
      height: 100,
      color: Theme.of(context).dividerColor,
    );
  }

  Widget _getTableColumn({
    required String label,
    required CrossAxisAlignment alignment,
    required Widget first,
    required Widget second,
    required Widget third,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignment,
        children: [
          Center(child: FittedBox(child: Text(label))),
          const SizedBox(height: 1),
          FittedBox(child: first),
          const SizedBox(height: 1),
          FittedBox(child: second),
          const SizedBox(height: 1),
          FittedBox(child: third),
        ],
      ),
    );
  }
}
