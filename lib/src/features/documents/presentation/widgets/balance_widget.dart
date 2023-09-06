import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../../../../core/data/utils/currency_utils.dart';

class BalanceWidget extends StatelessWidget {
  final double earnings;
  final double expenses;
  final double balance;

  const BalanceWidget({
    super.key,
    required this.earnings,
    required this.expenses,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${'earnings-text'.i18n([
            CurrencyUtils.format(earnings),
          ])}\n${'expenses-text'.i18n([
            CurrencyUtils.format(expenses),
          ])}\n${'balance-text'.i18n([
            CurrencyUtils.format(balance),
          ])}',
      child: Row(
        children: [
          Text('balance-text'.i18n([''])),
          Expanded(
            child: Text(
              CurrencyUtils.format(balance),
              style: TextStyle(
                color: balance == 0
                    ? AppThemes.commonColor
                    : balance.isNegative
                        ? Colors.red[300]
                        : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
