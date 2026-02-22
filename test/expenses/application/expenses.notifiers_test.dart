import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('expensesProvider', () {
    const accountId = 'acc-1';
    const otherAccountId = 'acc-2';
    final interval = (
      type: DateIntervalType.day,
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 1, 31),
    );

    test('returns all expenses for account when category is not provided',
        () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(interval),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2025, 1, 5),
        amount: 10,
      );

      await _addExpense(
        repo,
        id: 'exp-2',
        accountId: accountId,
        category: 'Travel',
        date: DateTime(2025, 1, 10),
        amount: 20,
      );

      await _addExpense(
        repo,
        id: 'exp-3',
        accountId: otherAccountId,
        category: 'Food',
        date: DateTime(2025, 1, 6),
        amount: 15,
      );

      final result =
          await container.read(expensesProvider(accountId: accountId).future);

      expect(result, hasLength(2));
      expect(result.map((e) => e.category).toSet(), {'Food', 'Travel'});
      expect(repo.loadExpensesCalls, 1);
      expect(repo.lastCategory, isNull);
      expect(repo.lastAccountId, accountId);
      expect(repo.lastStartDate, interval.startDate);
      expect(repo.lastEndDate, interval.endDate);
    });

    test('filters expenses by provided category', () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(interval),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2025, 1, 5),
        amount: 10,
      );

      await _addExpense(
        repo,
        id: 'exp-2',
        accountId: accountId,
        category: 'Travel',
        date: DateTime(2025, 1, 6),
        amount: 15,
      );

      final result = await container.read(
        expensesProvider(accountId: accountId, category: 'Food').future,
      );

      expect(result, hasLength(1));
      expect(result.first.category, 'Food');
      expect(repo.loadExpensesCalls, 1);
      expect(repo.lastCategory, 'Food');
      expect(repo.lastAccountId, accountId);
    });

    test('handles empty category string', () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(interval),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: '',
        date: DateTime(2025, 1, 7),
        amount: 5,
      );

      await _addExpense(
        repo,
        id: 'exp-2',
        accountId: accountId,
        category: 'Utilities',
        date: DateTime(2025, 1, 8),
        amount: 30,
      );

      final result = await container.read(
        expensesProvider(accountId: accountId, category: '').future,
      );

      expect(result, hasLength(1));
      expect(result.first.category, isEmpty);
      expect(repo.loadExpensesCalls, 1);
      expect(repo.lastCategory, isEmpty);
    });

    test('returns empty list when no expenses match the category', () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(interval),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2025, 1, 5),
        amount: 10,
      );

      final result = await container.read(
        expensesProvider(accountId: accountId, category: 'Health').future,
      );

      expect(result, isEmpty);
      expect(repo.loadExpensesCalls, 1);
      expect(repo.lastCategory, 'Health');
    });

    test('applies date interval filtering alongside category filtering',
        () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(interval),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2024, 12, 31),
        amount: 50,
      );

      await _addExpense(
        repo,
        id: 'exp-2',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2025, 1, 15),
        amount: 25,
      );

      final result = await container.read(
        expensesProvider(accountId: accountId, category: 'Food').future,
      );

      expect(result, hasLength(1));
      expect(result.first.id, 'exp-2');
      expect(repo.loadExpensesCalls, 1);
      expect(repo.lastCategory, 'Food');
      expect(repo.lastStartDate, interval.startDate);
      expect(repo.lastEndDate, interval.endDate);
    });

    test('returns empty list when date interval is null', () async {
      final repo = _SpyExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        dateIntervalProvider.overrideWithValue(null),
      ]);
      addTearDown(container.dispose);

      await _addExpense(
        repo,
        id: 'exp-1',
        accountId: accountId,
        category: 'Food',
        date: DateTime(2025, 1, 5),
        amount: 10,
      );

      final result =
          await container.read(expensesProvider(accountId: accountId).future);

      expect(result, isEmpty);
      expect(repo.loadExpensesCalls, 0);
    });
  });
}

Future<void> _addExpense(
  InMemoryExpensesRepository repo, {
  required String id,
  required String accountId,
  required String category,
  required DateTime date,
  required double amount,
}) {
  return repo.insertExpense(
    ExpenseModel(
      id: id,
      accountId: accountId,
      category: category,
      date: date,
      amount: amount,
    ),
  );
}

class _SpyExpensesRepository extends InMemoryExpensesRepository {
  int loadExpensesCalls = 0;
  String? lastAccountId;
  DateTime? lastStartDate;
  DateTime? lastEndDate;
  String? lastCategory;

  @override
  Future<List<ExpenseModel>> loadExpenses({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    String? category,
  }) {
    loadExpensesCalls++;
    lastAccountId = accountId;
    lastStartDate = startDate;
    lastEndDate = endDate;
    lastCategory = category;
    return super.loadExpenses(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      category: category,
    );
  }
}
