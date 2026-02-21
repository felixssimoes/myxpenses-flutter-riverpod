// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
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
    List<CategorySummary>? categorySummaries,
  }) async {
    if (categorySummaries != null && dateInterval == null) {
      throw ArgumentError(
        'dateInterval must be provided when overriding category summaries',
      );
    }

    await tester.pumpWidget(ProviderScope(
      overrides: [
        appRouterProvider.overrideWithValue(appRouter),
        accountsRepositoryProvider.overrideWithValue(accountsRepository),
        if (expensesRepository != null)
          expensesRepositoryProvider.overrideWithValue(expensesRepository),
        if (dateInterval != null)
          dateIntervalProvider.overrideWithValue(dateInterval),
        if (categorySummaries != null && dateInterval != null)
          categorySummariesProvider(
            accountId: accountId,
            dateInterval: dateInterval,
          ).overrideWith((ref) async => categorySummaries),
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

  void expectDateIntervalSelector() {
    final finder = find.byType(DateIntervalSelector);
    expect(finder, findsOneWidget);
  }

  void expectCategoryTileCount(int count) {
    final tileCount = find.byType(CategorySummaryTile).evaluate().length;
    expect(tileCount, count);
  }

  void expectCategoryTile({
    required int index,
    required String categoryName,
    required String expenseLabel,
    required String totalText,
  }) {
    final tileFinder = find.byType(CategorySummaryTile).at(index);
    expect(tileFinder, findsOneWidget);
    expect(
      find.descendant(of: tileFinder, matching: find.text(categoryName)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: tileFinder, matching: find.text(expenseLabel)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: tileFinder, matching: find.text(totalText)),
      findsOneWidget,
    );
  }

  void expectAccountTotal(String total) {
    final finder = find.byKey(const Key('account_total_text'));
    expect(finder, findsOneWidget);
    final textWidget = tester.widget<Text>(finder);
    expect(textWidget.data, total);
  }

  CategorySummary categorySummaryAt(int index) {
    final tileFinder = find.byType(CategorySummaryTile).at(index);
    expect(tileFinder, findsOneWidget);
    final tile = tester.widget<CategorySummaryTile>(tileFinder);
    return tile.summary;
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

  Future<void> tapCategoryTileAt(int index) async {
    final finder = find.byType(CategorySummaryTile).at(index);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapCategoryTileByName(String categoryName) async {
    final finder = find.widgetWithText(CategorySummaryTile, categoryName);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  // Backwards compatibility with older robot calls
  void expectFindNExpenses(int n) => expectCategoryTileCount(n);

  Future<void> tapExpenseTile(int index) => tapCategoryTileAt(index);
}
