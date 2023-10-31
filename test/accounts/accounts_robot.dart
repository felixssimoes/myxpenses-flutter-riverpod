// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

class AccountsRobot {
  AccountsRobot(this.tester);
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

  Future<void> tapAddAccountButton() async {
    await tester.tap(find.byKey(AccountsListScreen.addAccountKey));
    await tester.pumpAndSettle();
  }

  Future<void> tapAccountTile(int index) async {
    await tester.tap(find.byType(AccountListTile).at(index));
    await tester.pumpAndSettle();
  }
}
