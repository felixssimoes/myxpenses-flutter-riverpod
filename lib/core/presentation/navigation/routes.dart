enum Routes {
  // accounts
  accountsList('/accounts'),
  createAccount('create'),

  dummy('');

  const Routes(
    this.path,
  );

  final String path;
}
