// ignore_for_file: scoped_providers_should_specify_dependencies

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/presentation/details/widgets/account_expense_tile.dart';
import 'package:myxpenses/accounts/presentation/expenses_list/account_expenses_list.screen.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';

class AccountExpensesListRobot {
  AccountExpensesListRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpAccountExpensesList({
    required String accountId,
    String? category,
    ExpensesRepository? expensesRepository,
    AppRouter? appRouter,
    DateInterval? dateInterval,
    bool useRealDateIntervalProvider = false,
  }) async {
    final overrides = <Override>[
      if (expensesRepository != null)
        expensesRepositoryProvider.overrideWithValue(expensesRepository),
      if (appRouter != null) appRouterProvider.overrideWithValue(appRouter),
    ];

    final interval = dateInterval ?? _defaultInterval();
    final intervalRepository = DateIntervalRepository()
      ..setDateInterval(interval);
    overrides.add(
      dateIntervalRepositoryProvider.overrideWithValue(intervalRepository),
    );
    if (!useRealDateIntervalProvider) {
      overrides.add(dateIntervalProvider.overrideWithValue(interval));
    }

    await tester.pumpWidget(ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: AccountExpensesListScreen(
          accountId: accountId,
          category: category,
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  DateInterval _defaultInterval() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return (type: DateIntervalType.day, startDate: start, endDate: end);
  }

  Finder findTotalText() => find.byKey(const Key('account_expenses_total_text'));

  void expectTotal(String value) {
    final finder = findTotalText();
    expect(finder, findsOneWidget);
    final textWidget = tester.widget<Text>(finder);
    expect(textWidget.data, value);
  }

  void expectExpenseTiles(int count) {
    expect(find.byType(AccountExpenseTile), findsNWidgets(count));
  }

  int expenseTileCount() => tester.widgetList(find.byType(AccountExpenseTile)).length;

  void expectEmptyState() {
    expect(find.text('no expenses found'), findsOneWidget);
  }

  Future<void> tapFab() async {
    final finder = find.byType(FloatingActionButton);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapExpenseAt(int index) async {
    final finder = find.byType(AccountExpenseTile).at(index);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  String expenseCategoryAt(int index) {
    final widget = tester.widget<AccountExpenseTile>(
      find.byType(AccountExpenseTile).at(index),
    );
    return widget.expense.category;
  }

  void expectTitle(String text) {
    expect(find.text(text), findsOneWidget);
  }

  Future<void> tapPreviousInterval() async {
    final finder = find.byIcon(Icons.arrow_left);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapNextInterval() async {
    final finder = find.byIcon(Icons.arrow_right);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
