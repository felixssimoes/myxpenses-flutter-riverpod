import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import '../../../_helpers/mocks/mocks.dart';
import '../../accounts_robot.dart';
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
      when(repository.watchAccounts).thenAnswer((_) => Stream.value([a1, a2]));

      final r = AccountsRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindNAccounts(2);
      verify(repository.watchAccounts);
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
  });
}
