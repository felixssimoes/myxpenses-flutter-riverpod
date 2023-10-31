import 'package:myxpenses/accounts/data/accounts.repository.dart';
import 'package:myxpenses/accounts/domain/account.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.notifiers.g.dart';

@riverpod
Stream<List<AccountModel>> accounts(AccountsRef ref) =>
    ref.watch(accountsRepositoryProvider).watchAccounts;

@riverpod
Future<AccountModel> account(AccountRef ref, String accountId) async {
  final accounts = await ref.watch(accountsProvider.future);
  return accounts.firstWhere((account) => account.id == accountId);
}
