import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/application/category_summaries.notifier.dart';
import 'package:myxpenses/expenses/domain/category_summary.model.dart';

class AccountDetailsScreen extends ConsumerWidget {
  const AccountDetailsScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountView = ref.watch(accountViewProvider(accountId));
    final interval = ref.watch(dateIntervalProvider);
    final defaultAccountId = ref.watch(defaultAccountIdProvider);

    final categorySummariesValue = interval == null
        ? const AsyncValue<List<CategorySummary>>.data([])
        : ref.watch(
            categorySummariesProvider(
              accountId: accountId,
              dateInterval: interval,
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(accountView.valueOrNull?.account.name ?? ''),
        actions: [
          defaultAccountId.when(
            data: (defaultId) {
              final isDefault = defaultId == accountId;
              return IconButton(
                tooltip: isDefault
                    ? 'Clear default account'
                    : 'Set as default account',
                icon: Icon(
                  isDefault ? Icons.star : Icons.star_border,
                ),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    if (isDefault) {
                      await ref
                          .read(defaultAccountServiceProvider)
                          .clearDefaultAccount();
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Default account cleared'),
                        ),
                      );
                      return;
                    }

                    await ref
                        .read(defaultAccountServiceProvider)
                        .setDefaultAccount(accountId: accountId);
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Default account set'),
                      ),
                    );
                  } catch (error) {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Could not update default account'),
                      ),
                    );
                  }
                },
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (error, stackTrace) => IconButton(
              icon: const Icon(Icons.error_outline),
              tooltip: 'Retry loading default account',
              onPressed: () => ref.invalidate(defaultAccountIdProvider),
            ),
          ),
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
              value: categorySummariesValue,
              data: (summaries) {
                return ListView.builder(
                  itemCount: summaries.length,
                  itemBuilder: (context, index) {
                    final summary = summaries[index];
                    final bool isAllCategories =
                        summary.category.trim().isEmpty ||
                            summary.category == 'All categories';

                    final categoryTile = CategorySummaryTile(
                      summary: summary,
                      onTap: () => ref
                          .read(appRouterProvider)
                          .openAccountExpenses(
                            accountId,
                            category: isAllCategories ? null : summary.category,
                          ),
                    );

                    if (isAllCategories) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          categoryTile,
                          const Divider(height: 16),
                        ],
                      );
                    }

                    return categoryTile;
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(appRouterProvider).openCreateExpense(accountId),
        child: const Icon(Icons.add),
      ),
    );
  }
}
