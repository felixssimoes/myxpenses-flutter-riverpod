import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/core/presentation/navigation/app_router.dart';
import 'package:myxpenses/core/presentation/navigation/routes.dart';
import 'package:myxpenses/expenses/expenses.dart';

void main() {
  group('AppRouter account expenses', () {
    testWidgets(
        'openAccountExpenses without category navigates with accountId only',
        (tester) async {
      const accountId = 'account-123';
      final appRouter = await _pumpRouterApp(tester);

      appRouter.openAccountExpenses(accountId);
      await tester.pumpAndSettle();

      final uri = _currentUri(appRouter);
      expect(uri.path, '/accounts/details/$accountId/expenses');
      expect(uri.queryParameters, isEmpty);
    });

    testWidgets('openAccountExpenses with category adds query parameter',
        (tester) async {
      const accountId = 'account-123';
      const category = 'food';
      final appRouter = await _pumpRouterApp(tester);

      appRouter.openAccountExpenses(accountId, category: category);
      await tester.pumpAndSettle();

      final uri = _currentUri(appRouter);
      expect(uri.path, '/accounts/details/$accountId/expenses');
      expect(uri.queryParameters, {'category': category});
    });

    test('account expenses route is nested under account details', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final appRouter = container.read(appRouterProvider);

      final accountsRoute = appRouter.routerConfig.configuration.routes
          .whereType<GoRoute>()
          .singleWhere((route) => route.name == Routes.accountsList.name);
      final accountDetailsRoute = accountsRoute.routes
          .whereType<GoRoute>()
          .singleWhere((route) => route.name == Routes.accountDetails.name);

      final expenseRoutes = accountDetailsRoute.routes
          .whereType<GoRoute>()
          .where((route) => route.name == Routes.accountExpenses.name);

      expect(expenseRoutes, isNotEmpty);
    });

    test('account expenses route path matches Routes.accountExpenses', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final appRouter = container.read(appRouterProvider);

      final expensesRoute = _findAccountExpensesRoute(appRouter);
      expect(expensesRoute.path, Routes.accountExpenses.path);
    });

    testWidgets('account expenses route renders AccountExpensesListScreen',
        (tester) async {
      const accountId = 'account-123';
      const category = 'travel';
      final appRouter = await _pumpRouterApp(tester);

      appRouter.openAccountExpenses(accountId, category: category);
      await tester.pumpAndSettle();

      final screenFinder = find.byType(AccountExpensesListScreen);
      expect(screenFinder, findsOneWidget);

      final screen = tester.widget<AccountExpensesListScreen>(screenFinder);
      expect(screen.accountId, accountId);
      expect(screen.category, category);
    });
  });
}

Future<AppRouter> _pumpRouterApp(WidgetTester tester) async {
  final container = ProviderContainer(
    overrides: [
      accountsRepositoryProvider.overrideWithValue(
        InMemoryAccountsRepository(),
      ),
      expensesRepositoryProvider.overrideWithValue(
        InMemoryExpensesRepository(),
      ),
    ],
  );
  addTearDown(container.dispose);
  final appRouter = container.read(appRouterProvider);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: appRouter.routerConfig),
    ),
  );
  await tester.pumpAndSettle();
  return appRouter;
}

Uri _currentUri(AppRouter appRouter) {
  return appRouter.routerConfig.routerDelegate.currentConfiguration.uri;
}

GoRoute _findAccountExpensesRoute(AppRouter appRouter) {
  final accountsRoute = appRouter.routerConfig.configuration.routes
      .whereType<GoRoute>()
      .singleWhere((route) => route.name == Routes.accountsList.name);
  final accountDetailsRoute = accountsRoute.routes
      .whereType<GoRoute>()
      .singleWhere((route) => route.name == Routes.accountDetails.name);
  return accountDetailsRoute.routes
      .whereType<GoRoute>()
      .singleWhere((route) => route.name == Routes.accountExpenses.name);
}
