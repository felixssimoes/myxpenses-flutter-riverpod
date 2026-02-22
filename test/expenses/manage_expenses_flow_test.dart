import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/expenses/expenses.dart';

import '../_helpers/mocks.dart';
import '../robot.dart';

void main() {
  testWidgets('create, update and delete expense flow', (tester) async {
    final accountsRepo = InMemoryAccountsRepository();
    final expensesRepo = InMemoryExpensesRepository();

    accountsRepo.insertAccount(mockAccountModel());

    final r = Robot(tester);
    await r.pumpApp(
      accountsRepository: accountsRepo,
      expensesRepository: expensesRepo,
    );
    await tester.pumpAndSettle();
    await r.accounts.list.tapAccountTile(0);
    expect(find.byType(AccountDetailsScreen), findsOneWidget);

    // create expense
    await r.accounts.details.tapAddExpense();
    expect(find.byType(CreateExpenseScreen), findsOneWidget);
    await r.expenses.create.setExpenseCategory('Food');
    await r.expenses.create.setExpenseAmount('10.00');
    await r.expenses.create.tapCreateExpense();

    await tester.pumpAndSettle();
    r.accounts.details.expectFindNExpenses(2);
    r.accounts.details.expectAccountTotal('10.00');
    expect(find.text('Food'), findsOneWidget);

    final allCategoriesSummary = r.accounts.details.categorySummaryAt(0);
    final foodSummary = r.accounts.details.categorySummaryAt(1);
    expect(allCategoriesSummary.total, 10.0);
    expect(foodSummary.category, 'Food');
    expect(foodSummary.total, 10.0);

    // update expense
    await r.accounts.details.tapExpenseTile(0);
    await r.accounts.expensesList.tapExpenseAt(0);
    expect(find.byType(EditExpenseScreen), findsOneWidget);
    await r.expenses.create.setExpenseCategory('Lunch');
    await r.expenses.create.setExpenseAmount('11.00');
    await r.expenses.edit.tapUpdateExpense();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    r.accounts.details.expectFindNExpenses(2);
    r.accounts.details.expectAccountTotal('11.00');
    expect(find.text('Food'), findsNothing);
    expect(find.text('10.00'), findsNothing);
    expect(find.text('Lunch'), findsOneWidget);

    final updatedAllCategoriesSummary = r.accounts.details.categorySummaryAt(0);
    final lunchSummary = r.accounts.details.categorySummaryAt(1);
    expect(updatedAllCategoriesSummary.total, 11.0);
    expect(lunchSummary.category, 'Lunch');
    expect(lunchSummary.total, 11.0);

    // delete expense
    await r.accounts.details.tapExpenseTile(0);
    await r.accounts.expensesList.tapExpenseAt(0);
    await r.expenses.edit.tapDeleteExpense();
    await r.expenses.edit.tapConfirmExpenseDeleteAlertDeleteButton();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate((widget) => widget is EditExpenseScreen),
      findsNothing,
    );
    r.accounts.details.expectFindNExpenses(0);
    await tester.pumpAndSettle();
    r.accounts.details.expectAccountTotal('0.00');
    expect(find.text('Food'), findsNothing);
    expect(find.text('10.00'), findsNothing);
    expect(find.text('Lunch'), findsNothing);
    expect(find.text('11.00'), findsNothing);
  });
}
