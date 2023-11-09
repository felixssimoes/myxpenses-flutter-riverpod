import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_expense.controller.freezed.dart';
part 'create_expense.controller.g.dart';

@riverpod
class CreateExpenseController extends _$CreateExpenseController {
  @override
  Future<CreateExpenseState> build({required String accountId}) async {
    return CreateExpenseState(accountId: accountId);
  }

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
      return CreateExpenseState(
        accountId: accountId,
        category: category,
        amount: double.parse(amount),
        date: date,
      );
    });
  }
}

@freezed
class CreateExpenseState with _$CreateExpenseState {
  const factory CreateExpenseState({
    required String accountId,
    String? category,
    double? amount,
    DateTime? date,
  }) = _CreateExpenseState;
}
