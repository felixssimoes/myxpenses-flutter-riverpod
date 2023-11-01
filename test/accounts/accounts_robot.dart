// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/accounts/presentation/widgets/account_name_form_field.dart';

class AccountsRobot {
  AccountsRobot(this.tester);
  final WidgetTester tester;

  Future<void> openCreateAccount() async {
    final finder = find.byKey(AccountsListScreen.addAccountKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> setAccountName(String name) async {
    final finder =
        find.byWidgetPredicate((widget) => widget is AccountNameFormField);
    expect(finder, findsOneWidget);
    await tester.enterText(finder, name);
    await tester.pumpAndSettle();
  }

  Future<void> tapCreateAccount() async {
    final finder = find.text('Create Account');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void expectFindAccount(String name) {
    final finder = find.text(name);
    expect(finder, findsOneWidget);
  }
}
