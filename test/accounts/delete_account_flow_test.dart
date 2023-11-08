import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';

import '../_helpers/mocks/mocks.dart';
import '../robot.dart';

void main() {
  testWidgets('delete account flow', (tester) async {
    final repo = InMemoryAccountsRepository();
    await repo.insertAccount(mockAccountModel(name: 'Account to Delete'));
    await repo.insertAccount(mockAccountModel(name: 'My Account'));

    final r = Robot(tester);
    await r.pumpApp(accountsRepository: repo);

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
