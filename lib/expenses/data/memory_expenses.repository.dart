import '../expenses.dart';
import 'expenses.repository.dart';

class InMemoryExpensesRepository implements ExpensesRepository {
  final List<ExpenseModel> _expenses = [];

  @override
  Future<void> insertExpense(ExpenseModel expense) async {
    _expenses.add(expense);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final index = _expenses.indexWhere((a) => a.id == expense.id);
    if (index == -1) {
      throw Exception('Expense not found');
    }
    _expenses[index] = expense;
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    _expenses.removeWhere((a) => a.id == expense.id);
  }

  @override
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return _expenses
        .where((expense) => 
            expense.accountId == accountId &&
            !expense.date.isBefore(startDate) &&
            expense.date.isBefore(endDate))
        .toList();
  }

  @override
  Future<ExpenseModel?> loadExpense({required String id}) async {
    final index = _expenses.indexWhere((a) => a.id == id);
    if (index == -1) {
      throw Exception('Expense not found');
    }
    return _expenses[index];
  }

  @override
  Future<void> deleteAllExpensesForAccount(String accountId) async {
    _expenses.removeWhere((a) => a.accountId == accountId);
  }

  @override
  Future<Map<String, double>> loadAllAccountTotals({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final Map<String, double> totals = {};
    
    // Group expenses by account and calculate totals
    for (final expense in _expenses) {
      if (!expense.date.isBefore(startDate) && expense.date.isBefore(endDate)) {
        totals[expense.accountId] = (totals[expense.accountId] ?? 0.0) + expense.amount;
      }
    }
    
    return totals;
  }
}
