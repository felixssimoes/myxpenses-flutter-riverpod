import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../domain/account.model.dart';
import 'accounts.repository.dart';

part 'json_accounts.repository.freezed.dart';
part 'json_accounts.repository.g.dart';

class JsonAccountsRepository implements AccountsRepository {
  JsonAccountsRepository({
    required this.uuidGenerator,
  }) {
    _load();
  }

  _AccountsModel _accounts = const _AccountsModel(items: []);
  final _accountsSubject = BehaviorSubject<List<AccountModel>>.seeded([]);
  final Uuid uuidGenerator;

  @override
  List<AccountModel> get accounts => _accountsSubject.value;

  @override
  Stream<List<AccountModel>> get watchAccounts => _accountsSubject.stream;

  @override
  Future<AccountModel> createAccount({required String name}) async {
    final account = AccountModel(
      id: uuidGenerator.v4(),
      name: name,
    );
    await _update([..._accounts.items, account]);
    return account;
  }

  @override
  Future<AccountModel> updateAccount({required AccountModel account}) async {
    final index = _accounts.items.indexWhere((a) => a.id == account.id);
    if (index == -1) {
      throw Exception('Account not found');
    }
    final accs = _accounts.items;
    accs[index] = account;
    await _update(accs);
    return account;
  }

  @override
  Future<void> deleteAccount({required AccountModel account}) async {
    await _update(_accounts.items.where((a) => a.id != account.id).toList());
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('accounts');
    if (data == null) {
      _accounts = const _AccountsModel(items: []);
      _accountsSubject.add(_accounts.items);
      return;
    }
    _accounts = _AccountsModel.fromJson(json.decode(data));
    _accountsSubject.add(_accounts.items);
  }

  Future<void> _update(List<AccountModel> updatedList) {
    _accounts = _accounts.copyWith(items: updatedList);
    _accountsSubject.add(_accounts.items);
    return _save();
  }

  Future<void> _save() async {
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
