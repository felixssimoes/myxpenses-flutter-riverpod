import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/presentation/details/widgets/account_expense_tile.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';

class AccountExpensesListScreen extends ConsumerWidget {
  const AccountExpensesListScreen({
    required this.accountId,
    this.category,
    super.key,
  });

  final String accountId;
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesValue = ref.watch(
      expensesProvider(accountId: accountId, category: category),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(category ?? 'All expenses'),
      ),
      body: Column(
        children: [
          const DateIntervalSelector(),
          Expanded(
            child: AsyncValueWidget(
              value: expensesValue,
              data: (expenses) {
                final total = expenses.fold<double>(
                    0, (sum, expense) => sum + expense.amount);
                expenses.sort((a, b) => b.date.compareTo(a.date));
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Center(
                        child: Text(
                          total.toStringAsFixed(2),
                          key: const Key('account_expenses_total_text'),
                        ),
                      ),
                    ),
                    if (expenses.isEmpty)
                      const Expanded(
                        child: Center(child: Text('no expenses found')),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenses[index];
                            return AccountExpenseTile(expense: expense);
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(appRouterProvider)
            .openCreateExpense(accountId, category: category),
        child: const Icon(Icons.add),
      ),
    );
  }
}
