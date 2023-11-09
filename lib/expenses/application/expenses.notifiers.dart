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

// TODO: remove this when we have period selection done
@Riverpod(keepAlive: true)
Future<List<ExpenseModel>> allExpenses(
  AllExpensesRef ref, {
  required String accountId,
}) =>
    ref.watch(expensesProvider(
      accountId: accountId,
      startDate: DateTime(0),
      endDate: DateTime.now(),
    ).future);
