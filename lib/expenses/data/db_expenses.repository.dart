import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

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
    await _db.into(_db.expensesTable).insert(
          ExpensesTableCompanion.insert(
            id: expense.id,
            accountId: expense.accountId,
            category: expense.category,
            date: expense.date,
            amount: expense.amount,
          ),
        );
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    await _db.update(_db.expensesTable).replace(
          ExpensesTableCompanion(
            id: Value(expense.id),
            accountId: Value(expense.accountId),
            category: Value(expense.category),
            date: Value(expense.date),
            amount: Value(expense.amount),
          ),
        );
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    final count = await (_db.delete(_db.expensesTable)
          ..where((tbl) => tbl.id.isValue(expense.id)))
        .go();
    debugLog(
      'deleted account expense id ${expense.id} count: $count',
      name: 'db',
    );
  }

  @override
  Future<void> deleteAllExpensesForAccount(String accountId) async {
    final count = await (_db.delete(_db.expensesTable)
          ..where((tbl) => tbl.accountId.isValue(accountId)))
        .go();
    debugLog(
      'deleted expenses for account with id $accountId count: $count',
      name: 'db',
    );
  }
}
