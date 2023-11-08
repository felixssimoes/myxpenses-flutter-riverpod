// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import '../../../_helpers/mocks/mocks.dart';
import 'account_details.screen.robot.dart';
import 'account_details.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
])
void main() {
  group('AccountDetailsScreen', () {
    testWidgets('Initialization and basic functionality', (tester) async {
      final appRouter = MockAppRouter();
      final accountsRepository = MockAccountsRepository();
      final account = mockAccountModel();
      when(accountsRepository.loadAccounts())
          .thenAnswer((_) async => [account]);

      final r = AccountDetailsScreenRobot(tester);
      await r.pumpAccountDetailsScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
      );

      r.expectFindAccountNameTitle(account.name);
      await r.tapEditAccount();

      verify(appRouter.openEditAccount(account.id)).called(1);
      verifyNoMoreInteractions(appRouter);
    });
  });
}
