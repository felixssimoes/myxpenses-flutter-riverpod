import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/expenses/data/memory_expenses.repository.dart';

import '../_helpers/mocks.dart';
import '../robot.dart';

void main() {
  testWidgets('delete account flow', (tester) async {
    final accountsRepo = InMemoryAccountsRepository();
    final expensesRepo = InMemoryExpensesRepository();
    await accountsRepo
        .insertAccount(mockAccountModel(name: 'Account to Delete'));
    await accountsRepo.insertAccount(mockAccountModel(name: 'My Account'));

    final r = Robot(tester);
    await r.pumpApp(
      accountsRepository: accountsRepo,
      expensesRepository: expensesRepo,
    );

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
