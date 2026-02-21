import 'package:myxpenses/core/utils/log.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'default_account.repository.dart';

class PreferencesDefaultAccountRepository implements DefaultAccountRepository {
  PreferencesDefaultAccountRepository(this._preferences);

  static const _defaultAccountIdKey = 'default_account_id';

  final SharedPreferences _preferences;

  @override
  Future<String?> getDefaultAccountId() async {
    try {
      return _preferences.getString(_defaultAccountIdKey);
    } catch (error, stackTrace) {
      debugLogError('Failed to read default account id', error, stackTrace);
      return null;
    }
  }

  @override
  Future<void> setDefaultAccountId(String accountId) async {
    try {
      final success =
          await _preferences.setString(_defaultAccountIdKey, accountId);
      if (!success) {
        debugLogError('Failed to persist default account id');
      }
    } catch (error, stackTrace) {
      debugLogError('Error writing default account id', error, stackTrace);
    }
  }

  @override
  Future<void> clearDefaultAccount() async {
    try {
      final success = await _preferences.remove(_defaultAccountIdKey);
      if (!success) {
        debugLogError('Failed to clear default account id');
      }
    } catch (error, stackTrace) {
      debugLogError('Error clearing default account id', error, stackTrace);
    }
  }
}
