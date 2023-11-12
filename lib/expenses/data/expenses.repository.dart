import '../domain/expense.model.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<ExpenseModel?> loadExpense({required String id});
  Future<void> insertExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(ExpenseModel expense);
  Future<void> deleteAllExpensesForAccount(String accountId);
}
