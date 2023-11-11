import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_expense.controller.g.dart';

@riverpod
class EditExpenseController extends _$EditExpenseController {
  @override
  Future<void> build() async {}

  Future<void> updateExpense({
    required String expenseId,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final expense =
          await ref.read(expensesRepositoryProvider).loadExpense(id: expenseId);
      final updatedExpense = expense!.copyWith(
        category: category,
        amount: amount,
        date: date,
      );
      await ref.read(expensesServiceProvider).updateExpense(updatedExpense);
      ref.read(appRouterProvider).goBack();
    });
  }

  Future<void> deleteExpense({required String expenseId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final expense =
          await ref.read(expensesRepositoryProvider).loadExpense(id: expenseId);
      await ref.read(expensesServiceProvider).deleteExpense(expense!);
      ref.read(appRouterProvider).goBack();
    });
  }
}
