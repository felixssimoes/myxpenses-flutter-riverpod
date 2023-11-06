// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import '../../../_helpers/mocks/mocks.dart';
import 'edit_account.screen.robot.dart';
import 'edit_account.screen_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AccountsRepository,
])
void main() {
  group('EditAccountScreen', () {
    final appRouter = MockAppRouter();
    final accountsRepository = MockAccountsRepository();

    setUp(() {
      reset(appRouter);
      reset(accountsRepository);
      when(appRouter.goBack()).thenAnswer((_) async => true);
      when(accountsRepository.updateAccount(account: anyNamed('account')))
          .thenAnswer((invocation) async =>
              invocation.namedArguments[const Symbol('account')]);
    });

    testWidgets('Initialization and basic functionality', (tester) async {
      final account = mockAccountModel();
      when(accountsRepository.accounts).thenReturn([account]);
      when(accountsRepository.watchAccounts)
          .thenAnswer((_) => Stream.value([account]));

      final r = EditAccountScreenRobot(tester);
      await r.pumpEditAccountScreen(
        accountId: account.id,
        appRouter: appRouter,
        accountsRepository: accountsRepository,
      );

      r.expectFindAccountNameField(account.name);
      r.expectFindUpdateAccountButton();
      r.expectFindDeleteAccountButton();
      verifyZeroInteractions(appRouter);

      await r.tapUpdateAccountButton();
      verify(appRouter.goBack()).called(1);
    });

    group('delete account', () {
      testWidgets('deletes account on confirmation', (tester) async {
        final account = mockAccountModel();
        when(accountsRepository.accounts).thenReturn([account]);
        when(accountsRepository.watchAccounts)
            .thenAnswer((_) => Stream.value([account]));

        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );

        await r.tapDeleteAccountButton();
        r.expectFindConfirmAccountDeleteAlert();

        await r.tapConfirmAccountDeleteAlertDeleteButton();
        verify(accountsRepository.deleteAccount(account: account));
        verify(appRouter.goHome());
      });

      testWidgets('does not delete account on cancelation', (tester) async {
        final account = mockAccountModel();
        when(accountsRepository.accounts).thenReturn([account]);
        when(accountsRepository.watchAccounts)
            .thenAnswer((_) => Stream.value([account]));

        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );

        await r.tapDeleteAccountButton();
        r.expectFindConfirmAccountDeleteAlert();

        await r.tapConfirmAccountDeleteAlertCancelButton();
        verifyNever(
            accountsRepository.deleteAccount(account: anyNamed('account')));
        verifyNever(appRouter.goHome());
      });
    });

    group('update account name', () {
      final account1 = mockAccountModel();
      final account2 = mockAccountModel();

      setUp(() {
        when(accountsRepository.accounts).thenReturn([account1, account2]);
        when(accountsRepository.watchAccounts)
            .thenAnswer((_) => Stream.value([account1, account2]));
      });

      testWidgets('should call repository when name is valid', (tester) async {
        const newAccountName = 'New Account Name';
        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account1.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );
        await r.setAccountName(newAccountName);
        await r.tapUpdateAccountButton();

        verify(accountsRepository.updateAccount(
          account: account1.copyWith(name: newAccountName),
        )).called(1);
        verify(appRouter.goBack()).called(1);
        verifyNoMoreInteractions(appRouter);
      });

      testWidgets('should accept update with same name', (tester) async {
        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account1.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );
        await r.tapUpdateAccountButton();

        verify(accountsRepository.updateAccount(account: account1)).called(1);
        verify(appRouter.goBack()).called(1);
        verifyNoMoreInteractions(appRouter);
      });

      testWidgets('should show invalid account name error', (tester) async {
        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account1.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );

        await r.setAccountName('');
        await r.tapUpdateAccountButton();
        r.expectFindInvalidAccountNameError();

        verifyNever(accountsRepository.updateAccount(account: account1));
        verifyZeroInteractions(appRouter);
      });

      testWidgets('should show account name exists error', (tester) async {
        final r = EditAccountScreenRobot(tester);
        await r.pumpEditAccountScreen(
          accountId: account1.id,
          appRouter: appRouter,
          accountsRepository: accountsRepository,
        );

        await r.setAccountName(account2.name);
        await r.tapUpdateAccountButton();
        r.expectFindAccountNameExistsError();

        verifyNever(accountsRepository.updateAccount(account: account1));
        verifyZeroInteractions(appRouter);
      });
    });
  });
}
