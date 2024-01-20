import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import '../../../_helpers/mocks.dart';
import 'accounts_list.screen.robot.dart';
import 'accounts_list.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
])
void main() {
  group('AccountsListScreen', () {
    testWidgets('initialization and basic functionality', (tester) async {
      final repository = MockAccountsRepository();
      final appRouter = MockAppRouter();
      final a1 = mockAccountModel();
      final a2 = mockAccountModel();
      when(repository.loadAccounts()).thenAnswer((_) async => [a1, a2]);

      final r = AccountsListScreenRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindNAccounts(2);
      r.expectFindEmptyState(false);
      verify(repository.loadAccounts());
      verifyZeroInteractions(appRouter);

      await r.tapAddAccountButton();
      verify(appRouter.openCreateAccount());
      verifyNoMoreInteractions(appRouter);
      verifyNoMoreInteractions(repository);

      await r.tapAccountTile(0);
      verify(appRouter.openAccountDetails(a1.id));
      verifyNoMoreInteractions(appRouter);
      verifyNoMoreInteractions(repository);
    });

    testWidgets('empty state', (tester) async {
      final repository = MockAccountsRepository();
      final appRouter = MockAppRouter();
      when(repository.loadAccounts()).thenAnswer((_) async => []);

      final r = AccountsListScreenRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindNAccounts(0);
      r.expectFindEmptyState(true);
      verify(repository.loadAccounts());
      verifyNoMoreInteractions(repository);
      verifyZeroInteractions(appRouter);
    });
  });
}
