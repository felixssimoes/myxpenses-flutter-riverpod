import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_amount.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_category.dart';
import 'package:myxpenses/expenses/presentation/widgets/expense_date.dart';

class CreateExpenseScreenRobot {
  CreateExpenseScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpCreateExpenseScreen({
    required String accountId,
    required ExpensesRepository repository,
    required AppRouter appRouter,
    String? category,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          expensesRepositoryProvider.overrideWithValue(repository),
          appRouterProvider.overrideWithValue(appRouter),
        ],
        child: MaterialApp(
          home: CreateExpenseScreen(
            accountId: accountId,
            category: category,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder expectFindExpenseCategoryFormField() {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseCategoryFormField);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindExpenseAmountFormField() {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseAmountFormField);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindExpenseDateFormField() {
    final finder =
        find.byWidgetPredicate((widget) => widget is ExpenseDateFormField);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> setExpenseCategory(String category) async {
    final finder = expectFindExpenseCategoryFormField();
    await tester.enterText(finder, category);
    await tester.pumpAndSettle();
  }

  String readExpenseCategory() {
    final finder = expectFindExpenseCategoryFormField();
    final widget = tester.widget<ExpenseCategoryFormField>(finder);
    return widget.controller.text;
  }

  Future<void> setExpenseAmount(String amount) async {
    final finder = expectFindExpenseAmountFormField();
    await tester.enterText(finder, amount);
    await tester.pumpAndSettle();
  }

  Future<void> setExpenseDate(DateTime date) async {
    final finder = find.byKey(ExpenseDateFormField.setDateButtonKey);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await tester.tap(find.text(date.day.toString()));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  }

  Future<void> tapCreateExpense() async {
    final finder = find.text('Create Expense');
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
