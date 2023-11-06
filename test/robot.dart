import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

import 'accounts/accounts_robot.dart';

class Robot {
  Robot(this.tester) : accounts = AccountsRobot(tester);

  final WidgetTester tester;
  final AccountsRobot accounts;

  Future<ProviderContainer> pumpApp({
    AccountsRepository? accountsRepository,
  }) async {
    final container = ProviderContainer(
      overrides: [
        if (accountsRepository != null)
          accountsRepositoryProvider.overrideWithValue(accountsRepository),
      ],
    );
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MyXpensesApp(),
    ));
    await tester.pumpAndSettle();
    return container;
  }
}
