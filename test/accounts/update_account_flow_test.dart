import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/expenses/data/memory_expenses.repository.dart';

import '../_helpers/mocks.dart';
import '../robot.dart';

void main() {
  testWidgets('update account flow', (tester) async {
    final accountsRepo = InMemoryAccountsRepository();
    final expensesRepo = InMemoryExpensesRepository();
    await accountsRepo
        .insertAccount(mockAccountModel(name: 'Account to Update'));

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
    // 3. change account name and save
    await r.accounts.edit.setAccountName('Updated Account');
    await r.accounts.edit.tapUpdateAccountButton();
    // 4. expect to see the account name changed
    r.accounts.list.expectFindAccount('Updated Account');
  });
}
