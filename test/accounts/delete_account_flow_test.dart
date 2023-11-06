import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';

import '../robot.dart';

void main() {
  testWidgets('delete account flow', (tester) async {
    final r = Robot(tester);
    final container = await r.pumpApp();
    final repo = container.read(accountsRepositoryProvider);
    await repo.createAccount(name: 'Account to Delete');
    await repo.createAccount(name: 'My Account');

    await tester.pumpAndSettle();

    // 1. tap on the first account in the list
    await r.accounts.list.tapAccountTile(0);
    // 2. tap on the edit account button
    await r.accounts.details.tapEditAccount();
    // 3. tap on the delete account button
    await r.accounts.edit.tapDeleteAccountButton();
    await r.accounts.edit.tapConfirmAccountDeleteAlertDeleteButton();
    // 4. expect to see the account deleted from the list
    r.accounts.list.expectFindAccount('Account to Delete', visible: false);
    r.accounts.list.expectFindAccount('My Account');
  });
}
