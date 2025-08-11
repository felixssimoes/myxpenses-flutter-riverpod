import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  test('allows multiple expenses on same day with same category and amount',
      () async {
    final repo = InMemoryExpensesRepository();
    final container = ProviderContainer(overrides: [
      expensesRepositoryProvider.overrideWithValue(repo),
    ]);
    addTearDown(container.dispose);

    final service = container.read(expensesServiceProvider);

    const accountId = 'acc-1';
    const category = 'Food';
    final date = DateTime(2025, 8, 10);
    const amount = 12.50;

    // Create two expenses with identical business fields
    await service.createExpense(
      accountId: accountId,
      category: category,
      date: date,
      amount: amount,
    );

    await service.createExpense(
      accountId: accountId,
      category: category,
      date: date,
      amount: amount,
    );

    final results = await repo.loadExpenses(
      accountId: accountId,
      startDate: DateTime(date.year, date.month, date.day),
      endDate: DateTime(date.year, date.month, date.day + 1),
    );

    expect(results.length, 2);
    expect(results.every((e) => e.category == category), isTrue);
    expect(results.every((e) => e.amount == amount), isTrue);
  });
}
