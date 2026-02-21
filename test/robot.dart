import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/expenses/expenses.dart';

import 'accounts/accounts_robot.dart';
import 'expenses/expenses_robot.dart';

class Robot {
  Robot(this.tester);

  final WidgetTester tester;

  AccountsRobot? _accounts;
  AccountsRobot get accounts => _accounts ??= AccountsRobot(tester);

  ExpensesRobot? _expenses;
  ExpensesRobot get expenses => _expenses ??= ExpensesRobot(tester);

  Future<ProviderContainer> pumpApp({
    AccountsRepository? accountsRepository,
    ExpensesRepository? expensesRepository,
  }) async {
    final container = ProviderContainer(
      overrides: [
        if (accountsRepository != null)
          accountsRepositoryProvider.overrideWithValue(accountsRepository),
        if (expensesRepository != null)
          expensesRepositoryProvider.overrideWithValue(expensesRepository),
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
