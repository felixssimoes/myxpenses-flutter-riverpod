import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/presentation/navigation/app_router.dart';
import 'package:myxpenses/expenses/data/expenses.repository.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_amount.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_category.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_date.dart';

class EditExpenseScreenRobot {
  EditExpenseScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpEditExpenseScreen({
    required String expenseId,
    required ExpensesRepository expensesRepo,
    required AccountsRepository accountsRepo,
    required AppRouter appRouter,
  }) async {
    await tester.binding.setSurfaceSize(const Size(400 * 3, 1800 * 3));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          expensesRepositoryProvider.overrideWithValue(expensesRepo),
          accountsRepositoryProvider.overrideWithValue(accountsRepo),
          appRouterProvider.overrideWithValue(appRouter),
        ],
        child: MaterialApp(
          home: EditExpenseScreen(expenseId: expenseId),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder expectFindExpenseCategoryFormField([String? category]) {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseCategoryFormField);
    expect(finder, findsOneWidget);
    if (category != null) {
      expect(
        (finder.evaluate().first.widget as ExpenseCategoryFormField)
            .controller
            .text,
        category,
      );
    }
    return finder;
  }

  Finder expectFindExpenseAmountFormField([String? amount]) {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseAmountFormField);
    expect(finder, findsOneWidget);
    if (amount != null) {
      expect(
        (finder.evaluate().first.widget as ExpenseAmountFormField)
            .controller
            .text,
        amount,
      );
    }
    return finder;
  }

  Finder expectFindExpenseDateFormField([DateTime? date]) {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseDateFormField);
    expect(finder, findsOneWidget);
    if (date != null) {
      expect(
        (finder.evaluate().first.widget as ExpenseDateFormField).startDate,
        date,
      );
    }
    return finder;
  }

  Finder expectFindSaveExpenseChangesButton() {
    final finder = find.byKey(EditExpenseScreen.kSaveButtonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindDeleteExpenseButton() {
    final finder = find.byIcon(Icons.delete);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> setExpenseCategory(String category) async {
    final finder = expectFindExpenseCategoryFormField();
    await tester.enterText(finder, category);
    await tester.pumpAndSettle();
  }

  Future<void> setExpenseAmount(String amount) async {
    final finder = expectFindExpenseAmountFormField();
    await tester.enterText(finder, amount);
    await tester.pumpAndSettle();
  }

  Future<void> setExpenseDate(DateTime date) async {
    final finder = expectFindExpenseDateFormField();
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await tester.tap(find.text(date.day.toString()));
    await tester.pumpAndSettle();
  }

  Future<void> tapUpdateExpense() async {
    final finder = expectFindSaveExpenseChangesButton();
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapDeleteExpense() async {
    final finder = expectFindDeleteExpenseButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapCancel() async {
    final finder = find.text('Cancel');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapConfirmExpenseDeleteAlertDeleteButton() async {
    expect(find.text('Delete'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
  }
}
