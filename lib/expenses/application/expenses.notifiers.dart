import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses.notifiers.g.dart';

@Riverpod(keepAlive: true)
Future<List<ExpenseModel>> expenses(
  ExpensesRef ref, {
  required String accountId,
  required DateTime startDate,
  required DateTime endDate,
}) =>
    ref.watch(expensesRepositoryProvider).loadExpenses(
          accountId: accountId,
          startDate: startDate,
          endDate: endDate,
        );

@Riverpod(keepAlive: true)
Future<List<ExpenseModel>> allExpenses(
  AllExpensesRef ref, {
  required String accountId,
}) {
  final interval = ref.watch(dateIntervalProvider);
  return ref.watch(expensesProvider(
    accountId: accountId,
    startDate: interval.startDate,
    endDate: interval.endDate,
  ).future);
}
