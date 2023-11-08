import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/account.model.dart';
import 'accounts.repository.dart';

part 'json_accounts.repository.freezed.dart';
part 'json_accounts.repository.g.dart';

class JsonStoreAccountsRepository implements AccountsRepository {
  var _accounts = const _AccountsModel(items: []);

  @override
  Future<void> insertAccount(AccountModel account) async {
    _update([..._accounts.items, account]);
  }

  @override
  Future<void> updateAccount(AccountModel account) async {
    final index = _accounts.items.indexWhere((a) => a.id == account.id);
    if (index == -1) {
      throw Exception('Account not found');
    }
    final accs = List<AccountModel>.from(_accounts.items);
    accs[index] = account;
    _update(accs);
  }

  @override
  Future<void> deleteAccount(AccountModel account) async {
    await _update(_accounts.items.where((a) => a.id != account.id).toList());
  }

  @override
  Future<List<AccountModel>> loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('accounts');
    if (data != null) {
      _accounts = _AccountsModel.fromJson(jsonDecode(data));
    }
    return _accounts.items;
  }

  Future<void> _update(List<AccountModel> accounts) async {
    _accounts = _accounts.copyWith(items: accounts);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accounts', json.encode(_accounts.toJson()));
  }
}

@freezed
class _AccountsModel with _$AccountsModel {
  const factory _AccountsModel({
    required List<AccountModel> items,
  }) = __AccountsModel;

  factory _AccountsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsModelFromJson(json);
}
