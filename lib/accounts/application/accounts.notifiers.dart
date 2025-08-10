import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.notifiers.g.dart';

@Riverpod(keepAlive: true)
Future<List<AccountModel>> accounts(Ref ref) =>
    ref.watch(accountsRepositoryProvider).loadAccounts();

@Riverpod(keepAlive: true)
Future<AccountModel?> account(Ref ref, String accountId) async {
  final accounts = await ref.watch(accountsProvider.future);
  try {
    return (accounts).firstWhere((account) => account.id == accountId);
  } catch (e) {
    return null;
  }
}

typedef AccountView = ({AccountModel account, double total});

@Riverpod(keepAlive: true)
Future<List<AccountView>> accountsView(Ref ref) async {
  final accounts = await ref.watch(accountsProvider.future);
  final accountsView = <AccountView>[];
  for (final account in accounts) {
    final expenses =
        await ref.watch(expensesProvider(accountId: account.id).future);
    final total = expenses
        .where((expense) => expense.accountId == account.id)
        .fold<double>(
            0, (previousValue, expense) => previousValue + expense.amount);
    accountsView.add((account: account, total: total));
  }
  return accountsView;
}

@Riverpod(keepAlive: true)
Future<AccountView?> accountView(Ref ref, String accountId) async {
  final accounts = await ref.watch(accountsViewProvider.future);
  try {
    return (accounts).firstWhere((av) => av.account.id == accountId);
  } catch (e) {
    return null;
  }
}
