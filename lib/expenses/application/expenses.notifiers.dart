import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.notifiers.g.dart';

@riverpod
Future<List<ExpenseModel>> expenses(
  Ref ref, {
  required String accountId,
  String? category,
}) async {
  final interval = ref.watch(dateIntervalProvider);
  if (interval == null) {
    return [];
  }

  return ref.watch(expensesRepositoryProvider).loadExpenses(
        accountId: accountId,
        startDate: interval.startDate,
        endDate: interval.endDate,
        category: category,
      );
}

@riverpod
Future<ExpenseModel?> expense(
  Ref ref, {
  required String expenseId,
}) async {
  return ref.watch(expensesRepositoryProvider).loadExpense(id: expenseId);
}
