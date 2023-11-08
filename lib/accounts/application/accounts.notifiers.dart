import 'package:myxpenses/accounts/accounts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.notifiers.g.dart';

@Riverpod(keepAlive: true)
Future<List<AccountModel>> accounts(AccountsRef ref) =>
    ref.watch(accountsRepositoryProvider).loadAccounts();

@Riverpod(keepAlive: true)
Future<AccountModel?> account(AccountRef ref, String accountId) async {
  final accounts = await ref.watch(accountsProvider.future);
  try {
    return (accounts).firstWhere((account) => account.id == accountId);
  } catch (e) {
    return null;
  }
}
