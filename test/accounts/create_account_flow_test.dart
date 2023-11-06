import 'package:flutter_test/flutter_test.dart';

import '../robot.dart';

void main() {
  testWidgets('create account flow', (tester) async {
    const accountName = 'My Account';

    final r = Robot(tester);
    await r.pumpApp();
    await tester.pumpAndSettle();

    // 1. tap on add account button
    await r.accounts.list.tapAddAccountButton();
    // 2. enter account name
    await r.accounts.createAccount.setAccountName(accountName);
    // 3. tap on create account button
    await r.accounts.createAccount.tapCreateAccount();
    // 4. expect to see the new account in the list
    r.accounts.list.expectFindAccount(accountName);
  });
}
