import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';

class AccountExpenseTile extends ConsumerWidget {
  const AccountExpenseTile({
    required this.expense,
    super.key,
  });

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(expense.category),
      subtitle: Text(longDateFormatter.format(expense.date)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(expense.amount.toStringAsFixed(2)),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => ref.read(appRouterProvider).openEditExpense(expense),
    );
  }
}
