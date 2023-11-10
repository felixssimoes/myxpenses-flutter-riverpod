import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_expense.controller.g.dart';

@riverpod
class CreateExpenseController extends _$CreateExpenseController {
  @override
  Future<void> build({required String accountId}) async {}

  Future<void> createExpense(
    String accountId,
    String category,
    String amount,
    DateTime date,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(expensesServiceProvider).createExpense(
            accountId: accountId,
            category: category,
            amount: double.parse(amount),
            date: date,
          );
      ref.read(appRouterProvider).goBack();
    });
  }
}
