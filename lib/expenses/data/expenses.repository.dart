import '../domain/expense.model.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Load a single expense by id. The reason this is because there could be
  /// potentially a large number of expenses that could be loaded. If we were to
  /// load all expenses, we would have to load all expenses for all accounts.
  Future<ExpenseModel?> loadExpense({required String id});

  Future<void> insertExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(ExpenseModel expense);
  Future<void> deleteAllExpensesForAccount(String accountId);
}
