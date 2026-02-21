// ignore_for_file: scoped_providers_should_specify_dependencies

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';

import '../details/account_details.screen_test.mocks.dart';
import 'account_expenses_list.screen.robot.dart';

void main() {
  group('AccountExpensesListScreen', () {
    const accountId = 'account-1';
    const foodCategory = 'Food';
    const travelCategory = 'Travel';

    DateInterval buildInterval({
      DateTime? startDate,
      DateTime? endDate,
      DateIntervalType type = DateIntervalType.day,
    }) {
      return (
        type: type,
        startDate: startDate ?? DateTime(2024, 1, 1),
        endDate: endDate ?? DateTime(2025, 1, 1),
      );
    }

    ExpenseModel buildExpense({
      required String id,
      required double amount,
      required DateTime date,
      String category = foodCategory,
      String account = accountId,
    }) {
      return ExpenseModel(
        id: id,
        accountId: account,
        category: category,
        date: date,
        amount: amount,
      );
    }

    testWidgets('shows total text with correct sum', (tester) async {
      final repo = InMemoryExpensesRepository();
      final interval = buildInterval();
      await repo.insertExpense(buildExpense(
        id: 'expense-1',
        amount: 10.50,
        date: DateTime(2024, 1, 3),
        category: foodCategory,
      ));
      await repo.insertExpense(buildExpense(
        id: 'expense-2',
        amount: 20.30,
        date: DateTime(2024, 1, 4),
        category: travelCategory,
      ));

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        expensesRepository: repo,
        dateInterval: interval,
      );

      r.expectTotal('30.80');
    });

    testWidgets('shows expenses sorted descending by date', (tester) async {
      final repo = InMemoryExpensesRepository();
      final interval = buildInterval();
      final older = buildExpense(
        id: 'expense-older',
        amount: 20,
        date: DateTime(2024, 1, 1),
        category: 'Older',
      );
      final newer = buildExpense(
        id: 'expense-newer',
        amount: 10,
        date: DateTime(2024, 2, 1),
        category: 'Newer',
      );
      await repo.insertExpense(older);
      await repo.insertExpense(newer);

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        expensesRepository: repo,
        dateInterval: interval,
      );

      r.expectExpenseTiles(2);
      expect(r.expenseCategoryAt(0), 'Newer');
      expect(r.expenseCategoryAt(1), 'Older');
    });

    testWidgets('shows empty state when no expenses', (tester) async {
      final repo = InMemoryExpensesRepository();
      final r = AccountExpensesListRobot(tester);

      await r.pumpAccountExpensesList(
        accountId: accountId,
        expensesRepository: repo,
        dateInterval: buildInterval(),
      );

      r.expectEmptyState();
      expect(r.expenseTileCount(), 0);
    });

    testWidgets('tapping FAB calls openCreateExpense with category',
        (tester) async {
      final router = MockAppRouter();
      when(router.openCreateExpense(
        any,
        category: anyNamed('category'),
      )).thenReturn(null);

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        category: foodCategory,
        appRouter: router,
        expensesRepository: InMemoryExpensesRepository(),
        dateInterval: buildInterval(),
      );

      await r.tapFab();

      verify(router.openCreateExpense(accountId, category: foodCategory))
          .called(1);
    });

    testWidgets('tapping FAB passes null category when not provided',
        (tester) async {
      final router = MockAppRouter();
      when(router.openCreateExpense(
        any,
        category: anyNamed('category'),
      )).thenReturn(null);

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        appRouter: router,
        expensesRepository: InMemoryExpensesRepository(),
        dateInterval: buildInterval(),
      );

      await r.tapFab();

      verify(router.openCreateExpense(accountId, category: null)).called(1);
    });

    testWidgets('tapping expense tile navigates to edit expense',
        (tester) async {
      final router = MockAppRouter();
      when(router.openEditExpense(any)).thenReturn(null);

      final repo = InMemoryExpensesRepository();
      final expenseToTap = buildExpense(
        id: 'expense-to-tap',
        amount: 42,
        date: DateTime(2024, 1, 2),
        category: foodCategory,
      );
      await repo.insertExpense(expenseToTap);

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        appRouter: router,
        expensesRepository: repo,
        dateInterval: buildInterval(),
      );

      await r.tapExpenseAt(0);

      verify(router.openEditExpense(expenseToTap)).called(1);
    });

    testWidgets('date interval selector switches intervals', (tester) async {
      final repo = InMemoryExpensesRepository();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day, 12);
      final yesterday = today.subtract(const Duration(days: 1));

      await repo.insertExpense(buildExpense(
        id: 'today-expense',
        amount: 15,
        date: today,
        category: 'Today',
      ));
      await repo.insertExpense(buildExpense(
        id: 'yesterday-expense',
        amount: 20,
        date: yesterday,
        category: 'Yesterday',
      ));

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        expensesRepository: repo,
        useRealDateIntervalProvider: true,
      );

      r.expectExpenseTiles(1);
      expect(r.expenseCategoryAt(0), 'Today');

      await r.tapPreviousInterval();

      r.expectExpenseTiles(1);
      expect(r.expenseCategoryAt(0), 'Yesterday');
    });

    testWidgets('shows category title when provided', (tester) async {
      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        category: travelCategory,
        expensesRepository: InMemoryExpensesRepository(),
        dateInterval: buildInterval(),
      );

      r.expectTitle(travelCategory);
    });

    testWidgets('shows default title when category is null', (tester) async {
      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        expensesRepository: InMemoryExpensesRepository(),
        dateInterval: buildInterval(),
      );

      r.expectTitle('All expenses');
    });

    testWidgets('filters expenses by category', (tester) async {
      final repo = InMemoryExpensesRepository();
      await repo.insertExpense(buildExpense(
        id: 'food-expense',
        amount: 12,
        date: DateTime(2024, 2, 1),
        category: foodCategory,
      ));
      await repo.insertExpense(buildExpense(
        id: 'travel-expense',
        amount: 18,
        date: DateTime(2024, 2, 2),
        category: travelCategory,
      ));

      final r = AccountExpensesListRobot(tester);
      await r.pumpAccountExpensesList(
        accountId: accountId,
        category: foodCategory,
        expensesRepository: repo,
        dateInterval: buildInterval(),
      );

      r.expectExpenseTiles(1);
      expect(r.expenseCategoryAt(0), foodCategory);
    });
  });
}
