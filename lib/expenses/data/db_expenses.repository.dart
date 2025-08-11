import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';
import 'package:sqlite3/sqlite3.dart' show SqliteException;

import '../domain/expense.model.dart';
import 'expenses.repository.dart';

class DBExpensesRepository implements ExpensesRepository {
  DBExpensesRepository(this._ref);
  final Ref _ref;

  MyXpensesDatabase get _db => _ref.read(databaseProvider);

  @override
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final expensesTable = await (_db.select(_db.expensesTable)
          ..where((tbl) => tbl.accountId.isValue(accountId))
          ..where((tbl) => tbl.date.isBiggerOrEqualValue(startDate))
          ..where((tbl) => tbl.date.isSmallerThanValue(endDate)))
        .get();
    return expensesTable
        .map((row) => ExpenseModel(
              id: row.id,
              accountId: row.accountId,
              category: row.category,
              date: row.date,
              amount: row.amount,
            ))
        .toList();
  }

  @override
  Future<ExpenseModel?> loadExpense({required String id}) async {
    try {
      final expense = await (_db.select(_db.expensesTable)
            ..where((tbl) => tbl.id.isValue(id)))
          .getSingle();
      return ExpenseModel(
        id: expense.id,
        accountId: expense.accountId,
        category: expense.category,
        date: expense.date,
        amount: expense.amount,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> insertExpense(ExpenseModel expense) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.expensesTable).insert(
              ExpensesTableCompanion.insert(
                id: expense.id,
                accountId: expense.accountId,
                category: expense.category,
                date: expense.date,
                amount: expense.amount,
              ),
            );
      });
    } on SqliteException catch (e) {
      // If a unique constraint fails here, it must be on the id column only.
      // Since ids are generated with UUID v4, this should be extremely rare.
      throw DatabaseException('Failed to insert expense: ${e.message}');
    } catch (e) {
      throw DatabaseException('Unexpected error inserting expense: $e');
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await _db.transaction(() async {
        await (_db.update(_db.expensesTable)
              ..where((tbl) => tbl.id.isValue(expense.id)))
            .write(ExpensesTableCompanion(
          id: Value(expense.id),
          accountId: Value(expense.accountId),
          category: Value(expense.category),
          date: Value(expense.date),
          amount: Value(expense.amount),
        ));
      });
    } on SqliteException catch (e) {
      throw DatabaseException('Failed to update expense: ${e.message}');
    } catch (e) {
      throw DatabaseException('Unexpected error updating expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    try {
      final count = await (_db.delete(_db.expensesTable)
            ..where((tbl) => tbl.id.isValue(expense.id)))
          .go();
      debugLog(
        'deleted account expense id ${expense.id} count: $count',
        name: 'db',
      );
    } on SqliteException catch (e) {
      throw DatabaseException('Failed to delete expense: ${e.message}');
    } catch (e) {
      throw DatabaseException('Unexpected error deleting expense: $e');
    }
  }

  @override
  Future<void> deleteAllExpensesForAccount(String accountId) async {
    try {
      final count = await (_db.delete(_db.expensesTable)
            ..where((tbl) => tbl.accountId.isValue(accountId)))
          .go();
      debugLog(
        'deleted expenses for account with id $accountId count: $count',
        name: 'db',
      );
    } on SqliteException catch (e) {
      throw DatabaseException(
          'Failed to delete account expenses: ${e.message}');
    } catch (e) {
      throw DatabaseException('Unexpected error deleting account expenses: $e');
    }
  }

  @override
  Future<Map<String, double>> loadAllAccountTotals({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final result = await _db.customSelect(
      '''
      SELECT account_id, SUM(amount) as total
      FROM expenses_table
      WHERE date >= ? AND date < ?
      GROUP BY account_id
      ''',
      variables: [
        Variable.withDateTime(startDate),
        Variable.withDateTime(endDate),
      ],
    ).get();

    return Map.fromEntries(
      result.map((row) => MapEntry(
            row.read<String>('account_id'),
            row.readNullable<double>('total') ?? 0.0,
          )),
    );
  }
}
