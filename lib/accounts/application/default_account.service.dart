import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';

import '../data/default_account.repository.dart';

class DefaultAccountService {
  DefaultAccountService({
    required Ref ref,
    required Future<DefaultAccountRepository> Function() repositoryLoader,
    required void Function() onDefaultAccountChanged,
  })  : _ref = ref,
        _repositoryLoader = repositoryLoader,
        _onDefaultAccountChanged = onDefaultAccountChanged;

  final Ref _ref;
  final Future<DefaultAccountRepository> Function() _repositoryLoader;
  final void Function() _onDefaultAccountChanged;

  Future<void> setDefaultAccount({required String accountId}) async {
    final accounts = await _ref.read(accountsProvider.future);
    final accountExists = accounts.any((account) => account.id == accountId);
    if (!accountExists) {
      throw StateError('Account $accountId does not exist.');
    }

    final repository = await _repositoryLoader();
    await repository.setDefaultAccountId(accountId);
    _onDefaultAccountChanged();
  }

  Future<void> clearDefaultAccount() async {
    final repository = await _repositoryLoader();
    await repository.clearDefaultAccount();
    _onDefaultAccountChanged();
  }

  Future<String?> getDefaultAccountId() async {
    final repository = await _repositoryLoader();
    return repository.getDefaultAccountId();
  }
}
