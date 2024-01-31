import 'package:flutter_test/flutter_test.dart';

import 'presentation/create/create_expense_screen_robot.dart';
import 'presentation/edit/edit_expense_screen_robot.dart';

class ExpensesRobot {
  ExpensesRobot(this.tester)
      : create = CreateExpenseScreenRobot(tester),
        edit = EditExpenseScreenRobot(tester);

  final WidgetTester tester;
  final CreateExpenseScreenRobot create;
  final EditExpenseScreenRobot edit;
}
