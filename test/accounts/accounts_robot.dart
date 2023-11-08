import 'package:flutter_test/flutter_test.dart';

import 'presentation/create/create_account.screen.robot.dart';
import 'presentation/details/account_details.screen.robot.dart';
import 'presentation/edit/edit_account.screen.robot.dart';
import 'presentation/list/accounts_list.screen.robot.dart';

class AccountsRobot {
  AccountsRobot(this.tester)
      : list = AccountsListScreenRobot(tester),
        createAccount = CreateAccountScreenRobot(tester),
        details = AccountDetailsScreenRobot(tester),
        edit = EditAccountScreenRobot(tester);

  final WidgetTester tester;
  final AccountsListScreenRobot list;
  final CreateAccountScreenRobot createAccount;
  final AccountDetailsScreenRobot details;
  final EditAccountScreenRobot edit;
}
