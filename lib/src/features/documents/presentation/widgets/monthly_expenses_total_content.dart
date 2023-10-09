import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../../core/data/utils/app_themes.dart';
import '../../data/enums/month_enum.dart';
import '../../data/models/grouping_model.dart';
import '../../data/models/item_model.dart';
import 'item_total_tile.dart';

class MonthlyExpensesTotalContent extends StatelessWidget {
  final List<GroupingModel> groups;
  final List<MonthlyExpenseControlItemModel> selectedMonthItems;
  final MonthEnum selectedMonth;
  final double selectedMonthBalance;
  final double selectedMonthExpenses;
  final double selectedMonthEarnings;

  const MonthlyExpensesTotalContent({
    super.key,
    required this.groups,
    required this.selectedMonthItems,
    required this.selectedMonth,
    required this.selectedMonthBalance,
    required this.selectedMonthExpenses,
    required this.selectedMonthEarnings,
  });

  Iterable<MonthlyExpenseControlItemModel> itemsByGroup(String groupingId) {
    return selectedMonthItems.where((e) => e.groupingId == groupingId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              selectedMonth.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ItemTotalTile(
          title: 'earnings-text'.i18n(['']),
          price: selectedMonthEarnings,
          quantity: null,
        ),
        ItemTotalTile(
          title: 'expenses-text'.i18n(['']),
          price: selectedMonthExpenses,
          quantity: null,
          priceColor: Colors.red[300]!,
        ),
        ItemTotalTile(
          title: 'balance-text'.i18n(['']),
          price: selectedMonthBalance,
          quantity: null,
          priceColor: selectedMonthBalance == 0
              ? AppThemes.commonColor
              : (selectedMonthBalance > 0 ? Colors.green : Colors.red[300]!),
        ),
      ],
    );
  }
}
