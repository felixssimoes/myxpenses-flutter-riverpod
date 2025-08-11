import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';
import 'package:sqlite3/sqlite3.dart' show SqliteException;

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
    try {
      await _db.transaction(() async {
        await _db.into(_db.accountsTable).insert(
              AccountsTableCompanion.insert(
                id: account.id,
                name: account.name,
              ),
            );
      });
    } on SqliteException catch (e) {
      // 2067 = SQLITE_CONSTRAINT_UNIQUE (unique constraint failed)
      if (e.extendedResultCode == 2067) {
        throw AccountNameAlreadyExistsException();
      }
      throw DatabaseException('Failed to insert account.');
    } catch (e) {
      throw DatabaseException('Unexpected error inserting account.');
    }
  }

  @override
  Future<void> updateAccount(AccountModel account) async {
    try {
      await _db.transaction(() async {
        await (_db.update(_db.accountsTable)
              ..where((tbl) => tbl.id.isValue(account.id)))
            .write(AccountsTableCompanion(
          id: Value(account.id),
          name: Value(account.name),
        ));
      });
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        throw AccountNameAlreadyExistsException();
      }
      throw DatabaseException('Failed to update account.');
    } catch (e) {
      throw DatabaseException('Unexpected error updating account.');
    }
  }

  @override
  Future<void> deleteAccount(AccountModel account) async {
    try {
      final count = await (_db.delete(_db.accountsTable)
            ..where((tbl) => tbl.id.isValue(account.id)))
          .go();
      debugLog(
        'deleted account with id ${account.id} count: $count',
        name: 'db',
      );
    } on SqliteException catch (_) {
      throw DatabaseException('Failed to delete account.');
    } catch (e) {
      throw DatabaseException('Unexpected error deleting account.');
    }
  }
}
