import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  const accountId = 'account-1';
  final dateInterval = (
    type: DateIntervalType.month,
    startDate: DateTime(2025, 1, 1),
    endDate: DateTime(2025, 2, 1),
  );

  group('categorySummariesProvider', () {
    late InMemoryExpensesRepository repo;
    late ProviderContainer container;

    setUp(() {
      repo = InMemoryExpensesRepository();
      container = ProviderContainer(
        overrides: [
          expensesRepositoryProvider.overrideWithValue(repo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('returns empty list when there are no expenses', () async {
      final summaries = await container.read(
        categorySummariesProvider(
          accountId: accountId,
          dateInterval: dateInterval,
        ).future,
      );

      expect(summaries, isEmpty);
    });

    test('aggregates totals and counts per category', () async {
      final expenses = [
        ExpenseModel(
          id: 'exp-1',
          accountId: accountId,
          category: 'Food',
          date: DateTime(2025, 1, 5),
          amount: 10,
        ),
        ExpenseModel(
          id: 'exp-2',
          accountId: accountId,
          category: 'Food',
          date: DateTime(2025, 1, 10),
          amount: 15,
        ),
        ExpenseModel(
          id: 'exp-3',
          accountId: accountId,
          category: 'Travel',
          date: DateTime(2025, 1, 12),
          amount: 40,
        ),
        ExpenseModel(
          id: 'exp-4',
          accountId: accountId,
          category: 'Utilities',
          date: DateTime(2025, 1, 20),
          amount: 5,
        ),
      ];

      for (final expense in expenses) {
        await repo.insertExpense(expense);
      }

      final summaries = await container.read(
        categorySummariesProvider(
          accountId: accountId,
          dateInterval: dateInterval,
        ).future,
      );

      expect(summaries.length, 4);

      final allCategories =
          summaries.firstWhere((s) => s.category == 'All categories');
      expect(allCategories.total, 70);
      expect(allCategories.expenseCount, 4);

      final food = summaries.firstWhere((s) => s.category == 'Food');
      expect(food.total, 25);
      expect(food.expenseCount, 2);

      final travel = summaries.firstWhere((s) => s.category == 'Travel');
      expect(travel.total, 40);
      expect(travel.expenseCount, 1);

      final utilities = summaries.firstWhere((s) => s.category == 'Utilities');
      expect(utilities.total, 5);
      expect(utilities.expenseCount, 1);
    });

    test('sorts categories by total descending and prepends all categories row',
        () async {
      final expenses = [
        ExpenseModel(
          id: 'exp-1',
          accountId: accountId,
          category: 'Housing',
          date: DateTime(2025, 1, 3),
          amount: 80,
        ),
        ExpenseModel(
          id: 'exp-2',
          accountId: accountId,
          category: 'Groceries',
          date: DateTime(2025, 1, 4),
          amount: 30,
        ),
        ExpenseModel(
          id: 'exp-3',
          accountId: accountId,
          category: 'Groceries',
          date: DateTime(2025, 1, 7),
          amount: 20,
        ),
        ExpenseModel(
          id: 'exp-4',
          accountId: accountId,
          category: 'Leisure',
          date: DateTime(2025, 1, 9),
          amount: 10,
        ),
      ];

      for (final expense in expenses) {
        await repo.insertExpense(expense);
      }

      final summaries = await container.read(
        categorySummariesProvider(
          accountId: accountId,
          dateInterval: dateInterval,
        ).future,
      );

      expect(
        summaries.map((s) => s.category).toList(),
        ['All categories', 'Housing', 'Groceries', 'Leisure'],
      );

      expect(summaries.first.total, 140);
      expect(summaries.first.expenseCount, 4);

      expect(summaries[1].total, 80);
      expect(summaries[2].total, 50);
      expect(summaries[3].total, 10);
    });
  });
}
