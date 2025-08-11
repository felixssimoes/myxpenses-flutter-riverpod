import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';

import 'widgets/account_expense_tile.dart';

class AccountDetailsScreen extends ConsumerWidget {
  const AccountDetailsScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountView = ref.watch(accountViewProvider(accountId));
    return Scaffold(
      appBar: AppBar(
        title: Text(accountView.valueOrNull?.account.name ?? ''),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(appRouterProvider).openEditAccount(accountId),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          const DateIntervalSelector(),
          if (accountView.valueOrNull != null)
            Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Center(
                child: Text(
                  accountView.valueOrNull!.total.toStringAsFixed(2),
                  key: const Key('account_total_text'),
                ),
              ),
            ),
          Expanded(
            child: AsyncValueWidget(
              value: ref.watch(expensesProvider(accountId: accountId)),
              data: (expenses) {
                expenses.sort((a, b) => b.date.compareTo(a.date));
                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return AccountExpenseTile(expense: expense);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            ref.read(appRouterProvider).openCreateExpense(accountId),
      ),
    );
  }
}
