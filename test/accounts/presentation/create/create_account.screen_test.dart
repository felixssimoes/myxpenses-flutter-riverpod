import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import '../../../_helpers/mocks/mocks.dart';
import 'create_account.screen.robot.dart';
import 'create_account.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
])
void main() {
  group('CreateAccountScreen', () {
    late MockAccountsRepository repository;
    late MockAppRouter appRouter;

    setUp(() {
      repository = MockAccountsRepository();
      appRouter = MockAppRouter();

      when(repository.loadAccounts()).thenAnswer((_) async => []);
    });

    testWidgets('initialization and basic functionality', (tester) async {
      const accountName = 'test';
      when(repository.insertAccount(any)).thenAnswer((_) => Future.value());

      final r = CreateAccountScreenRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindAccountNameFormField();
      r.expectFindCreateAccountButton();

      await r.setAccountName(accountName);
      await r.tapCreateAccount();

      verify(repository.insertAccount(argThat(
        isA<AccountModel>().having((a) => a.name, 'name', accountName),
      ))).called(1);
      verify(appRouter.goBack());
      verifyNoMoreInteractions(appRouter);
    });

    testWidgets('invalid account name', (tester) async {
      final r = CreateAccountScreenRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindAccountNameFormField();
      r.expectFindCreateAccountButton();

      await r.setAccountName('');
      await r.tapCreateAccount();

      r.expectFindInvalidAccountNameError();
      verifyZeroInteractions(appRouter);
    });

    testWidgets('existing account name', (tester) async {
      await tester.runAsync(() async {
        const accountName = 'My Account';
        when(repository.loadAccounts())
            .thenAnswer((_) async => [mockAccountModel(name: accountName)]);

        final r = CreateAccountScreenRobot(tester);
        await r.pumpAccountsListScreen(
          repository: repository,
          appRouter: appRouter,
        );

        r.expectFindAccountNameFormField();
        r.expectFindCreateAccountButton();

        await r.setAccountName(accountName);
        await r.tapCreateAccount();

        r.expectFindAccountNameExistsError();
        verifyZeroInteractions(appRouter);
      });
    });
  });
}
