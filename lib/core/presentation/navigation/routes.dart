enum Routes {
  // accounts
  accountsList('/accounts'),
  createAccount('create'),
  accountDetails('details/:account_id'),
  accountExpenses('expenses'),
  editAccount('edit/:account_id'),

  // expenses
  createExpense('create_expense'),
  editExpense('create_expense/:expense_id'),

  dummy('');

  const Routes(
    this.path,
  );

  final String path;
}
