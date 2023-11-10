import '../domain/expense.model.dart';

abstract class ExpensesRepository {
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<void> insertExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(ExpenseModel expense);
}