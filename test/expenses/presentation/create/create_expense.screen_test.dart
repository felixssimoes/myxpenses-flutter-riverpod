import 'package:flutter_test/flutter_test.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';

import 'create_expense.screen_test.mocks.dart';
import 'create_expense_screen_robot.dart';

@GenerateMocks([
  AppRouter,
  ExpensesRepository,
])
void main() {
  group('CreateExpenseScreen', () {
    testWidgets('initialization and create expense', (tester) async {
      final accountId = mockUUID();
      final category = mockString();
      final amount = mockInteger(1, 100).toDouble();
      final date = DateTime.now().smartCopyWith(day: 1);

      final appRouter = MockAppRouter();
      final repository = MockExpensesRepository();
      when(repository.insertExpense(any)).thenAnswer((_) => Future.value());

      final r = CreateExpenseScreenRobot(tester);
      await r.pumpCreateExpenseScreen(
        accountId: accountId,
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindExpenseCategoryFormField();
      r.expectFindExpenseAmountFormField();
      r.expectFindExpenseDateFormField();

      await r.setExpenseCategory(category);
      await r.setExpenseAmount(amount.toString());
      await r.setExpenseDate(date);

      await r.tapCreateExpense();

      verify(repository.insertExpense(argThat(
        isA<ExpenseModel>()
            .having((a) => a.accountId, 'accountId', accountId)
            .having((a) => a.category, 'category', category)
            .having((a) => a.amount, 'amount', amount)
            .having((a) => a.date, 'date', date),
      ))).called(1);
      verify(appRouter.goBack());
      verifyNoMoreInteractions(appRouter);
    });

    testWidgets('prefills category when provided and allows change',
        (tester) async {
      final accountId = mockUUID();
      final preselectedCategory = mockString();
      final updatedCategory = mockString();
      final amount = mockInteger(1, 100).toDouble();
      final date = DateTime.now().smartCopyWith(day: 2);

      final appRouter = MockAppRouter();
      final repository = MockExpensesRepository();
      when(repository.insertExpense(any)).thenAnswer((_) => Future.value());

      final r = CreateExpenseScreenRobot(tester);
      await r.pumpCreateExpenseScreen(
        accountId: accountId,
        repository: repository,
        appRouter: appRouter,
        category: preselectedCategory,
      );

      expect(r.readExpenseCategory(), preselectedCategory);

      await r.setExpenseCategory(updatedCategory);
      await r.setExpenseAmount(amount.toString());
      await r.setExpenseDate(date);

      expect(r.readExpenseCategory(), updatedCategory);

      await r.tapCreateExpense();

      verify(repository.insertExpense(argThat(
        isA<ExpenseModel>()
            .having((a) => a.accountId, 'accountId', accountId)
            .having((a) => a.category, 'category', updatedCategory)
            .having((a) => a.amount, 'amount', amount)
            .having((a) => a.date, 'date', date),
      ))).called(1);
      verify(appRouter.goBack());
      verifyNoMoreInteractions(appRouter);
    });
  });
}
