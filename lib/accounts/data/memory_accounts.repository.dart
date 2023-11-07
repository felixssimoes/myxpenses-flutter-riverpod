import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../core/core.dart';
import '../domain/account.model.dart';
import 'accounts.repository.dart';

class MemoryAccountsRepository implements AccountsRepository {
  MemoryAccountsRepository({
    required this.uuidGenerator,
  });

  final _accounts = InMemoryStore<List<AccountModel>>([]);
  final Uuid uuidGenerator;

  @override
  List<AccountModel> get accounts => _accounts.value;

  @override
  Stream<List<AccountModel>> get watchAccounts => _accounts.stream;

  @override
  Future<AccountModel> createAccount({required String name}) async {
    final accounts = _accounts.value;
    final account = AccountModel(
      id: uuidGenerator.v4(),
      name: name,
    );
    accounts.add(account);
    _accounts.value = accounts;
    return account;
  }

  @override
  Future<void> deleteAccount({required AccountModel account}) async {
    _accounts.value =
        accounts.where((element) => element.id != account.id).toList();
  }

  @override
  Future<AccountModel> updateAccount({required AccountModel account}) async {
    final accs = accounts;
    final index = accs.indexWhere((a) => a.id == account.id);
    if (index == -1) {
      throw Exception('Account not found');
    }
    accs[index] = account;
    _accounts.value = accs;
    return account;
  }

  @visibleForTesting
  void reset() {
    _accounts.value = [];
  }
}
