import '../domain/account.model.dart';

abstract class AccountsRepository {
  Future<List<AccountModel>> loadAccounts();
  Future<void> insertAccount(AccountModel account);
  Future<void> updateAccount(AccountModel account);
  Future<void> deleteAccount(AccountModel account);
}
