// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/widgets/account_name_form_field.dart';
import 'package:myxpenses/core/core.dart';

class CreateAccountScreenRobot {
  CreateAccountScreenRobot(this.tester);
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
          home: CreateAccountScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder expectFindAccountNameFormField() {
    final finder =
        find.byWidgetPredicate((widget) => widget is AccountNameFormField);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindCreateAccountButton() {
    final finder = find.text('Create Account');
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindInvalidAccountNameError() {
    final finder = find.text('Please enter an account name');
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindAccountNameExistsError() {
    final finder = find.text('Account name already exists');
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> setAccountName(String name) async {
    final finder = expectFindAccountNameFormField();
    await tester.enterText(finder, name);
    await tester.pumpAndSettle();
  }

  Future<void> tapCreateAccount() async {
    final finder = expectFindCreateAccountButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
