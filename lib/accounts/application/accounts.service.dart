import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts.service.g.dart';

@Riverpod(keepAlive: true)
AccountsService accountsService(AccountsServiceRef ref) => AccountsService(ref);

class AccountsService {
  AccountsService(this._ref);
  final Ref _ref;

  Future<void> createAccount({required String name}) async {
    final account = AccountModel(
      id: _ref.read(uuidGeneratorProvider).v4(),
      name: name,
    );
    _ref.read(accountsRepositoryProvider).insertAccount(account);
    _ref.invalidate(accountsProvider);
  }

  Future<void> updateAccount({required AccountModel account}) async {
    _ref.read(accountsRepositoryProvider).updateAccount(account);
    _ref.invalidate(accountsProvider);
  }

  Future<void> deleteAccount({required AccountModel account}) async {
    _ref.read(accountsRepositoryProvider).deleteAccount(account);
    _ref.invalidate(accountsProvider);
  }
}
