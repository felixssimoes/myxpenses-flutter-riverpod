// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/data/expenses.repository.dart';

import '../../../_helpers/mocks.dart';
import 'account_details.screen.robot.dart';
import 'account_details.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
  ExpensesRepository,
])
void main() {
  group('AccountDetailsScreen', () {
    late AccountModel account;
    late MockAppRouter appRouter;
    late MockAccountsRepository accountsRepository;

    setUp(() {
      appRouter = MockAppRouter();
      accountsRepository = MockAccountsRepository();
      account = mockAccountModel();
      when(accountsRepository.loadAccounts())
          .thenAnswer((_) async => [account]);
    });

    testWidgets('Initialization and basic functionality', (tester) async {
      final r = AccountDetailsScreenRobot(tester);
      await r.pumpAccountDetailsScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
      );

      r.expectFindAccountNameTitle(account.name);
      await r.tapEditAccount();
      verify(appRouter.openEditAccount(account.id)).called(1);

      r.expectFindAddExpenseButton();
      await r.tapAddExpense();
      verify(appRouter.openCreateExpense(account.id)).called(1);

      verifyNoMoreInteractions(appRouter);
    });

    testWidgets('Show accounts expenses', (tester) async {
      await tester.runAsync(() async {
        final expensesRepository = MockExpensesRepository();
        when(expensesRepository.loadExpenses(
          accountId: anyNamed('accountId'),
          startDate: anyNamed('startDate'),
          endDate: anyNamed('endDate'),
        )).thenAnswer((_) async => [mockExpenseModel(), mockExpenseModel()]);

        final r = AccountDetailsScreenRobot(tester);
        await r.pumpAccountDetailsScreen(
          accountId: account.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
          expensesRepository: expensesRepository,
          dateInterval: mockDateInterval(),
        );

        r.expectFindNExpenses(2);
      });
    });
  });
}
