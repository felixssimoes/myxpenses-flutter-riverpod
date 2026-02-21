import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ExpensesService', () {
    test('allows multiple expenses on same day with same category and amount',
        () async {
      final repo = InMemoryExpensesRepository();
      final container = ProviderContainer(overrides: [
        expensesRepositoryProvider.overrideWithValue(repo),
        accountsRepositoryProvider.overrideWithValue(
          InMemoryAccountsRepository(),
        ),
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

    group('_invalidateExpenseRelatedProviders', () {
      const accountId = 'acc-1';
      const category = 'Food';
      final interval = (
        type: DateIntervalType.month,
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2025, 2, 1),
      );

      late InMemoryExpensesRepository expensesRepo;
      late InMemoryAccountsRepository accountsRepo;
      late ProviderContainer container;

      setUp(() async {
        expensesRepo = InMemoryExpensesRepository();
        accountsRepo = InMemoryAccountsRepository();
        await accountsRepo.insertAccount(
          AccountModel(id: accountId, name: 'Checking'),
        );
      });

      tearDown(() {
        container.dispose();
      });

      test('createExpense invalidates expense-related providers', () async {
        const expenseId = 'expense-create-1';

        container = ProviderContainer(
          overrides: [
            expensesRepositoryProvider.overrideWithValue(expensesRepo),
            accountsRepositoryProvider.overrideWithValue(accountsRepo),
            dateIntervalProvider.overrideWith((ref) => interval),
            uuidGeneratorProvider.overrideWithValue(_FixedUuid(expenseId)),
          ],
        );

        final listeners = _listenToProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        addTearDown(() => listeners.dispose());

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
          expectMissingExpense: true,
        );
        listeners.clear();

        final service = container.read(expensesServiceProvider);

        await service.createExpense(
          accountId: accountId,
          category: category,
          date: interval.startDate,
          amount: 10,
        );

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );

        listeners.expectAllInvalidated();
      });

      test('updateExpense invalidates expense-related providers', () async {
        const expenseId = 'expense-update-1';
        final expense = ExpenseModel(
          id: expenseId,
          accountId: accountId,
          category: category,
          date: interval.startDate,
          amount: 10,
        );
        await expensesRepo.insertExpense(expense);

        container = ProviderContainer(
          overrides: [
            expensesRepositoryProvider.overrideWithValue(expensesRepo),
            accountsRepositoryProvider.overrideWithValue(accountsRepo),
            dateIntervalProvider.overrideWith((ref) => interval),
          ],
        );

        final listeners = _listenToProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        addTearDown(() => listeners.dispose());

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        listeners.clear();

        final service = container.read(expensesServiceProvider);

        await service.updateExpense(expense.copyWith(amount: 15));

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );

        listeners.expectAllInvalidated();
      });

      test('deleteExpense invalidates expense-related providers', () async {
        const expenseId = 'expense-delete-1';
        final expense = ExpenseModel(
          id: expenseId,
          accountId: accountId,
          category: category,
          date: interval.startDate,
          amount: 20,
        );
        await expensesRepo.insertExpense(expense);

        container = ProviderContainer(
          overrides: [
            expensesRepositoryProvider.overrideWithValue(expensesRepo),
            accountsRepositoryProvider.overrideWithValue(accountsRepo),
            dateIntervalProvider.overrideWith((ref) => interval),
          ],
        );

        final listeners = _listenToProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        addTearDown(() => listeners.dispose());

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        listeners.clear();

        final service = container.read(expensesServiceProvider);

        await service.deleteExpense(expense);

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
          expectMissingExpense: true,
        );

        listeners.expectAllInvalidated();
      });

      test('skips interval invalidation when dateIntervalProvider is null',
          () async {
        const expenseId = 'expense-null-interval';
        final expense = ExpenseModel(
          id: expenseId,
          accountId: accountId,
          category: category,
          date: interval.startDate,
          amount: 30,
        );
        await expensesRepo.insertExpense(expense);

        container = ProviderContainer(
          overrides: [
            expensesRepositoryProvider.overrideWithValue(expensesRepo),
            accountsRepositoryProvider.overrideWithValue(accountsRepo),
            dateIntervalProvider.overrideWith((ref) => null),
          ],
        );

        final listeners = _listenToProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        addTearDown(() => listeners.dispose());

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );
        listeners.clear();

        final service = container.read(expensesServiceProvider);

        await service.updateExpense(expense.copyWith(amount: 35));

        await _primeProviders(
          container: container,
          accountId: accountId,
          category: category,
          interval: interval,
          expenseId: expenseId,
        );

        listeners.expectIntervalSkipped();
      });

      test('only the provided expenseId is invalidated', () async {
        const targetExpenseId = 'expense-target';
        const untouchedExpenseId = 'expense-untouched';

        final targetExpense = ExpenseModel(
          id: targetExpenseId,
          accountId: accountId,
          category: category,
          date: interval.startDate,
          amount: 40,
        );
        final untouchedExpense = targetExpense.copyWith(id: untouchedExpenseId);

        await expensesRepo.insertExpense(targetExpense);
        await expensesRepo.insertExpense(untouchedExpense);

        container = ProviderContainer(
          overrides: [
            expensesRepositoryProvider.overrideWithValue(expensesRepo),
            accountsRepositoryProvider.overrideWithValue(accountsRepo),
            dateIntervalProvider.overrideWith((ref) => interval),
          ],
        );

        final targetListener = RecordingListener<AsyncValue<ExpenseModel?>>();
        final untouchedListener = RecordingListener<AsyncValue<ExpenseModel?>>();
        final targetSub = container.listen(
          expenseProvider(expenseId: targetExpenseId),
          targetListener.call,
          fireImmediately: true,
        );
        final untouchedSub = container.listen(
          expenseProvider(expenseId: untouchedExpenseId),
          untouchedListener.call,
          fireImmediately: true,
        );

        addTearDown(targetSub.close);
        addTearDown(untouchedSub.close);

        await container.read(
          expenseProvider(expenseId: targetExpenseId).future,
        );
        await container.read(
          expenseProvider(expenseId: untouchedExpenseId).future,
        );

        targetListener.clear();
        untouchedListener.clear();

        final service = container.read(expensesServiceProvider);
        await service.updateExpense(targetExpense.copyWith(amount: 45));

        await container.read(
          expenseProvider(expenseId: targetExpenseId).future,
        );
        await container.read(
          expenseProvider(expenseId: untouchedExpenseId).future,
        );

        expect(targetListener.callCount, 2);
        expect(untouchedListener.calls, isEmpty);
      });
    });
  });
}

class _FixedUuid extends Uuid {
  _FixedUuid(this.value);

  final String value;

  @override
  String v4({V4Options? config, Map<String, dynamic>? options}) => value;
}

Future<void> _primeProviders({
  required ProviderContainer container,
  required String accountId,
  required String category,
  required DateInterval interval,
  String? expenseId,
  bool includeExpense = true,
  bool expectMissingExpense = false,
}) async {
  await Future.wait([
    container.read(expensesProvider(accountId: accountId).future),
    container
        .read(expensesProvider(accountId: accountId, category: category).future),
    container.read(accountsViewProvider.future),
    container.read(accountViewProvider(accountId).future),
    container
        .read(categorySummariesProvider(accountId: accountId, dateInterval: interval).future),
  ]);

  if (includeExpense && expenseId != null) {
    final expenseFuture = container.read(
      expenseProvider(expenseId: expenseId).future,
    );

    if (expectMissingExpense) {
      expect(await expenseFuture, isNull);
    } else {
      await expenseFuture;
    }
  }
}

_ProviderListeners _listenToProviders({
  required ProviderContainer container,
  required String accountId,
  required String category,
  required DateInterval interval,
  required String expenseId,
}) {
  final categorySummariesListener =
      RecordingListener<AsyncValue<List<CategorySummary>>>();
  final expensesListener = RecordingListener<AsyncValue<List<ExpenseModel>>>();
  final expensesByCategoryListener =
      RecordingListener<AsyncValue<List<ExpenseModel>>>();
  final accountViewListener = RecordingListener<AsyncValue<AccountView?>>();
  final accountsViewListener =
      RecordingListener<AsyncValue<List<AccountView>>>();
  final expenseListener = RecordingListener<AsyncValue<ExpenseModel?>>();

  final categorySummariesSub = container.listen(
    categorySummariesProvider(accountId: accountId, dateInterval: interval),
    categorySummariesListener.call,
    fireImmediately: true,
  );
  final expensesSub = container.listen(
    expensesProvider(accountId: accountId),
    expensesListener.call,
    fireImmediately: true,
  );
  final expensesByCategorySub = container.listen(
    expensesProvider(accountId: accountId, category: category),
    expensesByCategoryListener.call,
    fireImmediately: true,
  );
  final accountViewSub = container.listen(
    accountViewProvider(accountId),
    accountViewListener.call,
    fireImmediately: true,
  );
  final accountsViewSub = container.listen(
    accountsViewProvider,
    accountsViewListener.call,
    fireImmediately: true,
  );
  final expenseSub = container.listen(
    expenseProvider(expenseId: expenseId),
    expenseListener.call,
    fireImmediately: true,
  );

  return _ProviderListeners(
    categorySummaries: categorySummariesListener,
    expenses: expensesListener,
    expensesByCategory: expensesByCategoryListener,
    accountView: accountViewListener,
    accountsView: accountsViewListener,
    expense: expenseListener,
    subscriptions: [
      categorySummariesSub,
      expensesSub,
      expensesByCategorySub,
      accountViewSub,
      accountsViewSub,
      expenseSub,
    ],
  );
}

class RecordingListener<T> {
  final List<(T?, T?)> calls = [];

  void call(T? previous, T? next) {
    calls.add((previous, next));
  }

  void clear() => calls.clear();

  int get callCount => calls.length;
}

class _ProviderListeners {
  _ProviderListeners({
    required this.categorySummaries,
    required this.expenses,
    required this.expensesByCategory,
    required this.accountView,
    required this.accountsView,
    required this.expense,
    required this.subscriptions,
  });

  final RecordingListener<AsyncValue<List<CategorySummary>>> categorySummaries;
  final RecordingListener<AsyncValue<List<ExpenseModel>>> expenses;
  final RecordingListener<AsyncValue<List<ExpenseModel>>> expensesByCategory;
  final RecordingListener<AsyncValue<AccountView?>> accountView;
  final RecordingListener<AsyncValue<List<AccountView>>> accountsView;
  final RecordingListener<AsyncValue<ExpenseModel?>> expense;
  final List<ProviderSubscription<dynamic>> subscriptions;

  void clear() {
    for (final listener in _allListeners) {
      listener.clear();
    }
  }

  void expectAllInvalidated() {
    final counts = {
      'categorySummaries': categorySummaries.callCount,
      'expenses': expenses.callCount,
      'expensesByCategory': expensesByCategory.callCount,
      'accountView': accountView.callCount,
      'accountsView': accountsView.callCount,
      'expense': expense.callCount,
    };

    expect(categorySummaries.callCount, 2, reason: counts.toString());
    expect(expenses.callCount, 2, reason: counts.toString());
    expect(expensesByCategory.callCount, 2, reason: counts.toString());
    expect(accountView.callCount, 2, reason: counts.toString());
    expect(accountsView.callCount, 2, reason: counts.toString());
    expect(expense.callCount, 2, reason: counts.toString());
  }

  void expectIntervalSkipped() {
    expect(categorySummaries.callCount, 0);
    expect(expenses.callCount, 2);
    expect(expensesByCategory.callCount, 2);
    expect(accountView.callCount, 2);
    expect(accountsView.callCount, 2);
    expect(expense.callCount, 2);
  }

  void dispose() {
    for (final sub in subscriptions) {
      sub.close();
    }
  }

  Iterable<RecordingListener<dynamic>> get _allListeners => [
        categorySummaries,
        expenses,
        expensesByCategory,
        accountView,
        accountsView,
        expense,
      ];
}
