import '../domain/expense.model.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    String? category,
  });

  /// Load a single expense by id.
  /// The reason for having a method to load a single record this in expenses
  /// and not in accounts is because there could be potentially
  /// a large number of expenses stored.
  /// Otherwise we'd have to load all expenses for an account and then
  /// filter them by id. As said before, this could be thousands of records
  /// to be filtered and only use a couple of them.
  Future<ExpenseModel?> loadExpense({required String id});

  Future<void> insertExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(ExpenseModel expense);
  Future<void> deleteAllExpensesForAccount(String accountId);

  /// Load all account totals in batch to avoid N+1 query problem
  Future<Map<String, double>> loadAllAccountTotals({
    required DateTime startDate,
    required DateTime endDate,
  });
}
