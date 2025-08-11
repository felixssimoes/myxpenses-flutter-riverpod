import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.service.g.dart';

@riverpod
ExpensesService expensesService(Ref ref) => ExpensesService(ref);

class ExpensesService {
  ExpensesService(this._ref);
  final Ref _ref;

  Future<ExpenseModel> createExpense({
    required String accountId,
    required String category,
    required DateTime date,
    required double amount,
  }) async {
    final expense = ExpenseModel(
      id: _ref.read(uuidGeneratorProvider).v4(),
      accountId: accountId,
      category: category,
      date: date,
      amount: amount,
    );
    await _validateExpense(expense);
    await _ref.read(expensesRepositoryProvider).insertExpense(expense);
  // Invalidate only the affected account’s providers
  _ref.invalidate(expensesProvider(accountId: accountId));
  _ref.invalidate(accountViewProvider(accountId));
  _ref.invalidate(accountsViewProvider);
    return expense;
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _validateExpense(expense);
    await _ref.read(expensesRepositoryProvider).updateExpense(expense);
  _ref.invalidate(expenseProvider(expenseId: expense.id));
  _ref.invalidate(expensesProvider(accountId: expense.accountId));
  _ref.invalidate(accountViewProvider(expense.accountId));
  _ref.invalidate(accountsViewProvider);
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    await _ref.read(expensesRepositoryProvider).deleteExpense(expense);
  _ref.invalidate(expenseProvider(expenseId: expense.id));
  _ref.invalidate(expensesProvider(accountId: expense.accountId));
  _ref.invalidate(accountViewProvider(expense.accountId));
  _ref.invalidate(accountsViewProvider);
  }

  Future<void> _validateExpense(ExpenseModel expense) async {
    if (expense.category.isEmpty) {
      throw InvalidExpenseCategoryException();
    }

    if (expense.amount <= 0) {
      throw InvalidExpenseAmountException();
    }
  }
}
