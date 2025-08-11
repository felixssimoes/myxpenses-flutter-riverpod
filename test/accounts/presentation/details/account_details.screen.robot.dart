// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/details/widgets/account_expense_tile.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/data/expenses.repository.dart';
import 'package:myxpenses/expenses/expenses.dart';

class AccountDetailsScreenRobot {
  AccountDetailsScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountDetailsScreen({
    required String accountId,
    required AppRouter appRouter,
    required AccountsRepository accountsRepository,
    ExpensesRepository? expensesRepository,
    DateInterval? dateInterval,
  }) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        appRouterProvider.overrideWithValue(appRouter),
        accountsRepositoryProvider.overrideWithValue(accountsRepository),
        if (expensesRepository != null)
          expensesRepositoryProvider.overrideWithValue(expensesRepository),
        if (dateInterval != null)
          dateIntervalProvider.overrideWithValue(dateInterval),
      ],
      child: MaterialApp(
        home: AccountDetailsScreen(accountId: accountId),
      ),
    ));
    await tester.pumpAndSettle();
  }

  void expectFindAccountNameTitle(String accountName) {
    final finder = find.text(accountName);
    expect(finder, findsOneWidget);
  }

  Finder expectFindEditAccountButton() {
    final finder = find.byIcon(Icons.settings);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindAddExpenseButton() {
    final finder = find.byIcon(Icons.add);
    expect(finder, findsOneWidget);
    return finder;
  }

  void expectFindNExpenses(int n) {
    final finder = find.byType(AccountExpenseTile);
    expect(finder, findsNWidgets(n));
  }

  void expectAccountTotal(String total) {
    final finder = find.byKey(const Key('account_total_text'));
    expect(finder, findsOneWidget);
  final textWidget = tester.widget<Text>(finder);
  expect(textWidget.data, total);
  }

  Future<void> tapEditAccount() async {
    final finder = expectFindEditAccountButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapAddExpense() async {
    final finder = expectFindAddExpenseButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapExpenseTile(int index) async {
    final finder = find.byType(AccountExpenseTile).at(index);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
