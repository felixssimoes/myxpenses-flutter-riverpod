import '../domain/account.model.dart';

abstract class AccountsRepository {
  List<AccountModel> get accounts;
  Stream<List<AccountModel>> get watchAccounts;
  Future<AccountModel> createAccount({required String name});
  Future<AccountModel> updateAccount({required AccountModel account});
  Future<void> deleteAccount({required AccountModel account});
}
