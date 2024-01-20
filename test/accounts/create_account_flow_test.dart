import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/data/memory_accounts.repository.dart';
import 'package:myxpenses/expenses/data/memory_expenses.repository.dart';

import '../robot.dart';

void main() {
  testWidgets('create account flow', (tester) async {
    const accountName = 'My Account';
    final accountsRepo = InMemoryAccountsRepository();
    final expensesRepo = InMemoryExpensesRepository();

    final r = Robot(tester);
    await r.pumpApp(
      accountsRepository: accountsRepo,
      expensesRepository: expensesRepo,
    );
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
