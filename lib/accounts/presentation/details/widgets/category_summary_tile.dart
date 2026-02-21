import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/expenses/domain/category_summary.model.dart';

class CategorySummaryTile extends StatelessWidget {
  const CategorySummaryTile({
    required this.summary,
    required this.onTap,
    super.key,
  });

  final CategorySummary summary;
  final VoidCallback onTap;

  static final NumberFormat _currencyFormat = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    final bool isAllCategories =
        summary.category.trim().isEmpty || summary.category == 'All categories';
    final String categoryName =
        isAllCategories ? 'All categories' : summary.category;
    final String expenseLabel = summary.expenseCount == 1
        ? '1 expense'
        : '${summary.expenseCount} expenses';

    final TextStyle? titleStyle = isAllCategories
        ? Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w700)
        : null;

    return ListTile(
      title: Text(categoryName, style: titleStyle),
      subtitle: Text(expenseLabel),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_currencyFormat.format(summary.total)),
          const Icon(Icons.chevron_right),
        ],
      ),
      tileColor: isAllCategories
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : null,
      onTap: onTap,
    );
  }
}
