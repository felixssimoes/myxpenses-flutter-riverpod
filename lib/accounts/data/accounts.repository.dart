import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../core/core.dart';
import '../domain/account.model.dart';

part 'accounts.repository.g.dart';

@Riverpod(keepAlive: true)
AccountsRepository accountsRepository(AccountsRepositoryRef ref) =>
    AccountsRepository(ref);

class AccountsRepository {
  AccountsRepository(this._ref) {
    loadAccounts();
  }
  final AccountsRepositoryRef _ref;

  Uuid get uuidGenerator => _ref.read(uuidGeneratorProvider);

  final _accounts = <AccountModel>[];
  final _accountsSubject = BehaviorSubject<List<AccountModel>>();

  List<AccountModel> get accounts => _accounts;

  Stream<List<AccountModel>> get watchAccounts => _accountsSubject.stream;

  Future<AccountModel> createAccount({required String name}) async {
    final account = AccountModel(
      id: uuidGenerator.v4(),
      name: name,
    );
    _accounts.add(account);
    _accountsSubject.add(_accounts);
    return account;
  }

  Future<AccountModel> updateAccount({required AccountModel account}) async {
    final index = _accounts.indexWhere((a) => a.id == account.id);
    if (index == -1) {
      throw Exception('Account not found');
    }
    _accounts[index] = account;
    _accountsSubject.add(_accounts);
    return account;
  }

  Future<void> deleteAccount({required AccountModel account}) async {
    _accounts.removeWhere((a) => a.id == account.id);
    _accountsSubject.add(_accounts);
  }

  Future<List<AccountModel>> loadAccounts() async {
    await Future.delayed(const Duration(seconds: 2));
    _accountsSubject.add(_accounts);
    return _accounts;
  }
}
