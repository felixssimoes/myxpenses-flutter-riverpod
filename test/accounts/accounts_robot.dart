// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter_test/flutter_test.dart';

import 'presentation/create/create_account.screen.robot.dart';
import 'presentation/list/accounts_list.screen.robot.dart';

class AccountsRobot {
  AccountsRobot(this.tester)
      : list = AccountsListScreenRobot(tester),
        createAccount = CreateAccountScreenRobot(tester);

  final WidgetTester tester;
  final AccountsListScreenRobot list;
  final CreateAccountScreenRobot createAccount;
}
