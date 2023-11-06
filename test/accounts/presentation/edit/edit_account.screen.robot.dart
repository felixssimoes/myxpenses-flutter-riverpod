// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/widgets/account_name_form_field.dart';
import 'package:myxpenses/core/core.dart';

class EditAccountScreenRobot {
  EditAccountScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpEditAccountScreen({
    required String accountId,
    required AppRouter appRouter,
    required AccountsRepository accountsRepository,
  }) async {
    await tester.binding.setSurfaceSize(const Size(400 * 3, 1800 * 3));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountsRepositoryProvider.overrideWithValue(accountsRepository),
          appRouterProvider.overrideWithValue(appRouter),
        ],
        child: MaterialApp(
          home: EditAccountScreen(accountId: accountId),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder expectFindAccountNameField([String? name]) {
    final finder = find.byWidgetPredicate((widget) {
      if (widget is! AccountNameFormField) return false;
      if (name == null) return true;
      return widget.controller.text == name;
    });
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindUpdateAccountButton() {
    final finder = find.text('Update Account');
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectFindDeleteAccountButton() {
    final finder = find.byIcon(Icons.delete);
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

  void expectFindConfirmAccountDeleteAlert() {
    expect(find.text('Delete Account'), findsOneWidget);
    expect(
      find.text('Are you sure you want to delete this account?'),
      findsOneWidget,
    );
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  }

  Future<void> setAccountName(String name) async {
    final finder = expectFindAccountNameField();
    await tester.enterText(finder, name);
    await tester.pumpAndSettle();
  }

  Future<void> tapUpdateAccountButton() async {
    final finder = expectFindUpdateAccountButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapDeleteAccountButton() async {
    final finder = expectFindDeleteAccountButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapConfirmAccountDeleteAlertDeleteButton() async {
    final finder = find.text('Delete');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> tapConfirmAccountDeleteAlertCancelButton() async {
    final finder = find.text('Cancel');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
