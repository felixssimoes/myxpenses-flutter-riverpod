enum Routes {
  // accounts
  accountsList('/accounts'),
  createAccount('create'),
  accountDetails('details/:account_id'),
  editAccount('edit/:account_id'),

  // expenses
  createExpense('create_expense'),

  dummy('');

  const Routes(
    this.path,
  );

  final String path;
}
