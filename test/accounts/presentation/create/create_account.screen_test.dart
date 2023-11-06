// ignore_for_file: scoped_providers_should_specify_dependencies
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
    });

    testWidgets('initialization and basic functionality', (tester) async {
      var accountName = 'test';
      when(repository.createAccount(name: anyNamed('name')))
          .thenAnswer((_) async => mockAccountModel(name: accountName));
      when(repository.accounts).thenReturn([]);

      final r = CreateAccountScreenRobot(tester);
      await r.pumpAccountsListScreen(
        repository: repository,
        appRouter: appRouter,
      );

      r.expectFindAccountNameFormField();
      r.expectFindCreateAccountButton();

      await r.setAccountName(accountName);
      await r.tapCreateAccount();
      verify(repository.createAccount(name: accountName));
      verify(appRouter.goBack());
      verifyNoMoreInteractions(appRouter);
    });

    testWidgets('invalid account name', (tester) async {
      when(repository.accounts).thenReturn([]);

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
      const accountName = 'My Account';
      when(repository.accounts)
          .thenReturn([mockAccountModel(name: accountName)]);

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
}
