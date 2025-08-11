import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.notifiers.g.dart';

@riverpod
Future<List<AccountModel>> accounts(Ref ref) =>
    ref.watch(accountsRepositoryProvider).loadAccounts();

@riverpod
Future<AccountModel?> account(Ref ref, String accountId) async {
  final accounts = await ref.watch(accountsProvider.future);
  try {
    return (accounts).firstWhere((account) => account.id == accountId);
  } catch (e) {
    return null;
  }
}

typedef AccountView = ({AccountModel account, double total});

@riverpod
Future<List<AccountView>> accountsView(Ref ref) async {
  final accounts = await ref.watch(accountsProvider.future);
  final interval = ref.watch(dateIntervalProvider);

  if (interval == null || accounts.isEmpty) {
    return accounts.map((account) => (account: account, total: 0.0)).toList();
  }

  final totals =
      await ref.watch(expensesRepositoryProvider).loadAllAccountTotals(
            startDate: interval.startDate,
            endDate: interval.endDate,
          );

  return accounts
      .map((account) => (
            account: account,
            total: totals[account.id] ?? 0.0,
          ))
      .toList();
}

@riverpod
Future<AccountView?> accountView(Ref ref, String accountId) async {
  final accounts = await ref.watch(accountsViewProvider.future);
  try {
    return (accounts).firstWhere((av) => av.account.id == accountId);
  } catch (e) {
    return null;
  }
}
