import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

import '../domain/account.model.dart';
import 'accounts.repository.dart';

class DBAccountsRepository extends AccountsRepository {
  DBAccountsRepository(this._ref);
  final Ref _ref;

  MyXpensesDatabase get _db => _ref.read(databaseProvider);

  @override
  Future<List<AccountModel>> loadAccounts() async {
    final accounts = await _db.select(_db.accountsTable).get();
    return accounts
        .map((row) => AccountModel(id: row.id, name: row.name))
        .toList();
  }

  @override
  Future<void> insertAccount(AccountModel account) async {
    await _db.into(_db.accountsTable).insert(
          AccountsTableCompanion.insert(
            id: account.id,
            name: account.name,
          ),
        );
  }

  @override
  Future<void> updateAccount(AccountModel account) async {
    await _db.update(_db.accountsTable).replace(
          AccountsTableCompanion(
            id: Value(account.id),
            name: Value(account.name),
          ),
        );
  }

  @override
  Future<void> deleteAccount(AccountModel account) async {
    final count = await (_db.delete(_db.accountsTable)
          ..where((tbl) => tbl.id.isValue(account.id)))
        .go();
    debugLog(
      'deleted account with id ${account.id} count: $count',
      name: 'db',
    );
  }
}
