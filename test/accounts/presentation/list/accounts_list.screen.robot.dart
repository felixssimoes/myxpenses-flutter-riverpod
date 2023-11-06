// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/list/widgets/accounts_list_tile.dart';
import 'package:myxpenses/core/core.dart';

class AccountsListScreenRobot {
  AccountsListScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountsListScreen({
    required AccountsRepository repository,
    required AppRouter appRouter,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRouterProvider.overrideWithValue(appRouter),
          accountsRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          home: AccountsListScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void expectFindNAccounts(int count) {
    final finder = find.byType(AccountListTile);
    expect(finder, findsNWidgets(count));
  }

  void expectFindAccount(String name, {bool visible = true}) {
    final finder = find.text(name);
    expect(finder, visible ? findsOneWidget : findsNothing);
  }

  void expectFindEmptyState(bool visible) {
    final finder = find.text('no accounts created yet');
    expect(finder, visible ? findsOneWidget : findsNothing);
  }

  Future<void> tapAddAccountButton() async {
    final finder = find.byKey(AccountsListScreen.addAccountKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapAccountTile(int index) async {
    final finder = find.byType(AccountListTile).at(index);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
