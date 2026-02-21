abstract class DefaultAccountRepository {
  Future<String?> getDefaultAccountId();
  Future<void> setDefaultAccountId(String accountId);
  Future<void> clearDefaultAccount();
}
