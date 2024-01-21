import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/presentation/navigation/app_router.dart';
import 'package:myxpenses/expenses/data/expenses.repository.dart';

import '../../../_helpers/mocks.dart';
import 'edit_expense.screen_test.mocks.dart';
import 'edit_expense_screen_robot.dart';

@GenerateMocks([
  AppRouter,
  ExpensesRepository,
  AccountsRepository,
])
void main() {
  group('EditExpenseScreen', () {
    late MockAppRouter appRouter;
    late MockExpensesRepository expensesRepo;
    late MockAccountsRepository accountsRepo;

    final account = mockAccountModel();
    final expense = mockExpenseModel(accountId: account.id);

    setUp(() {
      appRouter = MockAppRouter();
      expensesRepo = MockExpensesRepository();
      accountsRepo = MockAccountsRepository();

      when(appRouter.goBack()).thenAnswer((_) async => true);
      when(accountsRepo.loadAccounts()).thenAnswer((_) async => [account]);
      when(expensesRepo.loadExpense(id: anyNamed('id')))
          .thenAnswer((_) async => expense);
    });

    testWidgets('initialization', (tester) async {
      final r = EditExpenseScreenRobot(tester);
      await r.pumpEditExpenseScreen(
        expenseId: expense.id,
        expensesRepo: expensesRepo,
        accountsRepo: accountsRepo,
        appRouter: appRouter,
      );

      r.expectFindExpenseCategoryFormField(expense.category);
      r.expectFindExpenseAmountFormField(expense.amount.toString());
      r.expectFindExpenseDateFormField(expense.date);
      r.expectFindDeleteExpenseButton();
      r.expectFindSaveExpenseChangesButton();
    });

    testWidgets('update expense', (tester) async {
      final r = EditExpenseScreenRobot(tester);
      await r.pumpEditExpenseScreen(
        expenseId: expense.id,
        expensesRepo: expensesRepo,
        accountsRepo: accountsRepo,
        appRouter: appRouter,
      );

      await r.setExpenseCategory('updated category');
      await r.setExpenseAmount('321');
      await r.tapUpdateExpense();

      verify(expensesRepo.updateExpense(expense.copyWith(
        category: 'updated category',
        amount: 321,
      ))).called(1);
      verify(appRouter.goBack()).called(1);
      verifyNoMoreInteractions(appRouter);
    });

    group('delete expense', () {
      testWidgets('is executed on confirmation', (tester) async {
        final r = EditExpenseScreenRobot(tester);
        await r.pumpEditExpenseScreen(
          expenseId: expense.id,
          expensesRepo: expensesRepo,
          accountsRepo: accountsRepo,
          appRouter: appRouter,
        );

        await r.tapDeleteExpense();
        await r.tapConfirmExpenseDeleteAlertDeleteButton();

        verify(expensesRepo.deleteExpense(expense)).called(1);
        verify(appRouter.goBack()).called(1);
        verifyNoMoreInteractions(appRouter);
      });

      testWidgets('does nothing on cancelation', (tester) async {
        final r = EditExpenseScreenRobot(tester);
        await r.pumpEditExpenseScreen(
          expenseId: expense.id,
          expensesRepo: expensesRepo,
          accountsRepo: accountsRepo,
          appRouter: appRouter,
        );

        await r.tapDeleteExpense();
        await r.tapCancel();

        verifyNever(expensesRepo.deleteExpense(any));
        verifyZeroInteractions(appRouter);
      });
    });
  });
}
