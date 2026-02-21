// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/data/expenses.repository.dart';
import 'package:myxpenses/expenses/domain/category_summary.model.dart';

import '../../../_helpers/mocks.dart';
import 'account_details.screen.robot.dart';
import 'account_details.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
  ExpensesRepository,
])
void main() {
  group('AccountDetailsScreen', () {
    final currencyFormatter = NumberFormat.simpleCurrency();
    late AccountModel account;
    late MockAppRouter appRouter;
    late MockAccountsRepository accountsRepository;

    setUp(() {
      appRouter = MockAppRouter();
      accountsRepository = MockAccountsRepository();
      account = mockAccountModel();
      when(accountsRepository.loadAccounts())
          .thenAnswer((_) async => [account]);
    });

    testWidgets('Initialization shows totals and primary actions', (tester) async {
      final expensesRepository = MockExpensesRepository();
      final dateInterval = mockDateInterval();

      when(expensesRepository.loadAllAccountTotals(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => {account.id: 0.0});

      when(expensesRepository.loadExpenses(
        accountId: anyNamed('accountId'),
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
        category: anyNamed('category'),
      )).thenAnswer((_) async => []);

      final r = AccountDetailsScreenRobot(tester);
      await r.pumpAccountDetailsScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
        expensesRepository: expensesRepository,
        dateInterval: dateInterval,
      );

      r.expectFindAccountNameTitle(account.name);
      r.expectDateIntervalSelector();
      r.expectAccountTotal('0.00');

      await r.tapEditAccount();
      verify(appRouter.openEditAccount(account.id)).called(1);

      r.expectFindAddExpenseButton();
      await r.tapAddExpense();
      verify(appRouter.openCreateExpense(account.id)).called(1);

      verifyNoMoreInteractions(appRouter);
    });

    testWidgets('Displays category summaries with all categories first',
        (tester) async {
      final expensesRepository = MockExpensesRepository();
      final dateInterval = mockDateInterval();

      when(expensesRepository.loadAllAccountTotals(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => {account.id: 180.0});

      final categorySummaries = [
        const CategorySummary(
          category: 'All categories',
          total: 180.0,
          expenseCount: 4,
        ),
        const CategorySummary(
          category: 'Groceries',
          total: 120.0,
          expenseCount: 3,
        ),
        const CategorySummary(
          category: 'Transport',
          total: 60.0,
          expenseCount: 1,
        ),
      ];

      final r = AccountDetailsScreenRobot(tester);
      await r.pumpAccountDetailsScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
        expensesRepository: expensesRepository,
        dateInterval: dateInterval,
        categorySummaries: categorySummaries,
      );

      r.expectCategoryTileCount(categorySummaries.length);
      r.expectCategoryTile(
        index: 0,
        categoryName: 'All categories',
        expenseLabel: '4 expenses',
        totalText: currencyFormatter.format(180.0),
      );
      r.expectCategoryTile(
        index: 1,
        categoryName: 'Groceries',
        expenseLabel: '3 expenses',
        totalText: currencyFormatter.format(120.0),
      );
      r.expectCategoryTile(
        index: 2,
        categoryName: 'Transport',
        expenseLabel: '1 expense',
        totalText: currencyFormatter.format(60.0),
      );
    });

    testWidgets('Tapping category summaries navigates with category filter',
        (tester) async {
      final expensesRepository = MockExpensesRepository();
      final dateInterval = mockDateInterval();

      when(expensesRepository.loadAllAccountTotals(
        startDate: anyNamed('startDate'),
        endDate: anyNamed('endDate'),
      )).thenAnswer((_) async => {account.id: 90.0});

      final categorySummaries = [
        const CategorySummary(
          category: 'All categories',
          total: 90.0,
          expenseCount: 3,
        ),
        const CategorySummary(
          category: 'Health',
          total: 50.0,
          expenseCount: 2,
        ),
      ];

      final r = AccountDetailsScreenRobot(tester);
      await r.pumpAccountDetailsScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
        expensesRepository: expensesRepository,
        dateInterval: dateInterval,
        categorySummaries: categorySummaries,
      );

      await r.tapCategoryTileAt(0);
      verify(appRouter.openAccountExpenses(account.id, category: null))
          .called(1);

      await r.tapCategoryTileByName('Health');
      verify(appRouter.openAccountExpenses(account.id, category: 'Health'))
          .called(1);

      verifyNoMoreInteractions(appRouter);
    });
  });
}
