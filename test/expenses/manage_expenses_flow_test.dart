import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/accounts/presentation/details/widgets/account_expense_tile.dart';
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

    // create expense
    await r.accounts.details.tapAddExpense();
    await r.expenses.create.setExpenseCategory('Food');
    await r.expenses.create.setExpenseAmount('10.00');
    await r.expenses.create.tapCreateExpense();

    r.accounts.details.expectFindNExpenses(1);
    await tester.pumpAndSettle();
    r.accounts.details.expectAccountTotal('10.00');
    expect(find.text('Food'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AccountExpenseTile).first,
        matching: find.text('10.00'),
      ),
      findsOneWidget,
    );

    // update expense
    await r.accounts.details.tapExpenseTile(0);
    await r.expenses.create.setExpenseCategory('Lunch');
    await r.expenses.create.setExpenseAmount('11.00');
    await r.expenses.edit.tapUpdateExpense();
    r.accounts.details.expectFindNExpenses(1);
    await tester.pumpAndSettle();
    r.accounts.details.expectAccountTotal('11.00');
    expect(find.text('Food'), findsNothing);
    expect(find.text('10.00'), findsNothing);
    expect(find.text('Lunch'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AccountExpenseTile).first,
        matching: find.text('11.00'),
      ),
      findsOneWidget,
    );

    // delete expense
    await r.accounts.details.tapExpenseTile(0);
    await r.expenses.edit.tapDeleteExpense();
    await r.expenses.edit.tapConfirmExpenseDeleteAlertDeleteButton();
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
