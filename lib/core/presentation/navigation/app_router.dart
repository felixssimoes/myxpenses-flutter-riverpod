import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myxpenses/expenses/expenses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../accounts/accounts.dart';
import 'routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> navigatorKey(Ref _) => GlobalKey<NavigatorState>();

@riverpod
AppRouter appRouter(Ref ref) => AppRouter(ref);

class AppRouter {
  AppRouter(this.ref) {
    _setupRoutes();
  }

  final Ref ref;
  bool _handledInitialNavigation = false;
  late final GoRouter _router;

  GoRouter get routerConfig => _router;

  void goBack() {
    _router.pop();
  }

  void goHome() {
    _router.go('/');
  }

  void openCreateAccount() {
    _router.goNamed(Routes.createAccount.name);
  }

  void openAccountDetails(String accountId) {
    _router.goNamed(
      Routes.accountDetails.name,
      pathParameters: {'account_id': accountId},
    );
  }

  void openAccountExpenses(String accountId, {String? category}) {
    _router.pushNamed(
      Routes.accountExpenses.name,
      pathParameters: {'account_id': accountId},
      queryParameters:
          category == null ? const {} : <String, String>{'category': category},
    );
  }

  void openEditAccount(String accountId) {
    _router.pushNamed(
      Routes.editAccount.name,
      pathParameters: {'account_id': accountId},
    );
  }

  void openCreateExpense(String accountId, {String? category}) {
    _router.pushNamed(
      Routes.createExpense.name,
      pathParameters: {'account_id': accountId},
      extra: category,
    );
  }

  void openEditExpense(ExpenseModel expense) {
    _router.pushNamed(
      Routes.editExpense.name,
      pathParameters: {
        'account_id': expense.accountId,
        'expense_id': expense.id,
      },
    );
  }

  void _setupRoutes() {
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: ref.watch(navigatorKeyProvider),
      initialLocation: Routes.accountsList.path,
      redirect: (context, state) async {
        if (state.matchedLocation == '/') {
          return Routes.accountsList.path;
        }

        final isInitialAccountsNavigation = !_handledInitialNavigation &&
            state.matchedLocation == Routes.accountsList.path;

        if (!isInitialAccountsNavigation) {
          return null;
        }

        _handledInitialNavigation = true;

        final defaultAccountId =
            await ref.read(defaultAccountIdProvider.future);
        if (defaultAccountId == null) {
          return null;
        }

        final accounts = await ref.read(accountsProvider.future);
        final accountExists =
            accounts.any((account) => account.id == defaultAccountId);
        if (!accountExists) {
          await ref.read(defaultAccountServiceProvider).clearDefaultAccount();
          return null;
        }

        final accountDetailsPath = Routes.accountDetails.path
            .replaceFirst(':account_id', defaultAccountId);
        return '${Routes.accountsList.path}/$accountDetailsPath';
      },
      routes: [
        GoRoute(
          path: Routes.accountsList.path,
          name: Routes.accountsList.name,
          builder: (context, state) => const AccountsListScreen(),
          routes: [
            GoRoute(
              path: Routes.createAccount.path,
              name: Routes.createAccount.name,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const CreateAccountScreen(),
              ),
            ),
            GoRoute(
              path: Routes.accountDetails.path,
              name: Routes.accountDetails.name,
              builder: (context, state) => AccountDetailsScreen(
                accountId: state.pathParameters['account_id']!,
              ),
              routes: [
                GoRoute(
                  path: Routes.accountExpenses.path,
                  name: Routes.accountExpenses.name,
                  builder: (context, state) => AccountExpensesListScreen(
                    accountId: state.pathParameters['account_id']!,
                    category: state.uri.queryParameters['category'],
                  ),
                ),
                GoRoute(
                  path: Routes.createExpense.path,
                  name: Routes.createExpense.name,
                  pageBuilder: (context, state) => MaterialPage<void>(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: CreateExpenseScreen(
                      accountId: state.pathParameters['account_id']!,
                      category: state.extra as String?,
                    ),
                  ),
                ),
                GoRoute(
                  path: Routes.editExpense.path,
                  name: Routes.editExpense.name,
                  builder: (context, state) => EditExpenseScreen(
                    expenseId: state.pathParameters['expense_id']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: Routes.editAccount.path,
              name: Routes.editAccount.name,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                fullscreenDialog: true,
                child: EditAccountScreen(
                  accountId: state.pathParameters['account_id']!,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
