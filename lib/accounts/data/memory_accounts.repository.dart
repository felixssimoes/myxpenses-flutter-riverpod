import '../domain/account.model.dart';
import 'accounts.repository.dart';

class InMemoryAccountsRepository implements AccountsRepository {
  final List<AccountModel> _accounts = [];

  @override
  Future<void> insertAccount(AccountModel account) async {
    _accounts.add(account);
  }

  @override
  Future<void> updateAccount(AccountModel account) async {
    final index = _accounts.indexWhere((a) => a.id == account.id);
    if (index == -1) {
      throw Exception('Account not found');
    }
    _accounts[index] = account;
  }

  @override
  Future<void> deleteAccount(AccountModel account) async {
    _accounts.removeWhere((a) => a.id == account.id);
  }

  @override
  Future<List<AccountModel>> loadAccounts() async {
    return _accounts;
  }
}
