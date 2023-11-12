import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.service.g.dart';

@Riverpod(keepAlive: true)
AccountsService accountsService(AccountsServiceRef ref) => AccountsService(ref);

class AccountsService {
  AccountsService(this._ref);
  final Ref _ref;

  Future<void> createAccount({required String name}) async {
    await _validateAccountName(name: name);
    final account = AccountModel(
      id: _ref.read(uuidGeneratorProvider).v4(),
      name: name,
    );
    await _ref.read(accountsRepositoryProvider).insertAccount(account);
    _ref.invalidate(accountsProvider);
  }

  Future<void> updateAccount({required AccountModel account}) async {
    await _validateAccountName(
      name: account.name,
      accountId: account.id,
    );
    await _ref.read(accountsRepositoryProvider).updateAccount(account);
    _ref.invalidate(accountsProvider);
  }

  Future<void> deleteAccount({required AccountModel account}) async {
    await _ref.read(accountsRepositoryProvider).deleteAccount(account);
    await _ref
        .read(expensesRepositoryProvider)
        .deleteAllExpensesForAccount(account.id);
    _ref.invalidate(accountsProvider);
    _ref.invalidate(expensesProvider);
    _ref.invalidate(expenseProvider);
  }

  Future<void> _validateAccountName({
    required String name,
    String? accountId,
  }) async {
    if (name.isEmpty) {
      throw InvalidAccountNameException();
    }

    final accounts = await _ref.read(accountsProvider.future);
    if (accounts.any((a) => a.name == name && a.id != accountId)) {
      throw AccountNameAlreadyExistsException();
    }
  }
}
