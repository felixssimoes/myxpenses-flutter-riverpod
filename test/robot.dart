import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myxpenses/core/core.dart';

import 'accounts/accounts_robot.dart';

class Robot {
  Robot(this.tester) : accounts = AccountsRobot(tester);

  final WidgetTester tester;
  final AccountsRobot accounts;

  Future<void> pumpApp() async {
    await tester.pumpWidget(const ProviderScope(
      child: MyXpensesApp(),
    ));
    await tester.pumpAndSettle();
  }
}
