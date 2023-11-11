import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.notifiers.g.dart';

@Riverpod(keepAlive: true)
Future<List<ExpenseModel>> expenses(
  ExpensesRef ref, {
  required String accountId,
}) async {
  final interval = ref.watch(dateIntervalProvider);
  if (interval == null) {
    return [];
  }

  return ref.watch(expensesRepositoryProvider).loadExpenses(
        accountId: accountId,
        startDate: interval.startDate,
        endDate: interval.endDate,
      );
}
