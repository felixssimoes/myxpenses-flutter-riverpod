// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

class AccountDetailsScreenRobot {
  AccountDetailsScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountDetailsScreen({
    required String accountId,
    required AppRouter appRouter,
    required AccountsRepository accountsRepository,
  }) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        appRouterProvider.overrideWithValue(appRouter),
        accountsRepositoryProvider.overrideWithValue(accountsRepository),
      ],
      child: MaterialApp(
        home: AccountDetailsScreen(accountId: accountId),
      ),
    ));
    await tester.pumpAndSettle();
  }

  void expectFindAccountNameTitle(String accountName) {
    final finder = find.text(accountName);
    expect(finder, findsOneWidget);
  }

  Finder expectFindEditAccountButton() {
    final finder = find.byIcon(Icons.settings);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> tapEditAccount() async {
    final finder = expectFindEditAccountButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
