sealed class AppException implements Exception {
  final String code;
  final String message;

  AppException._({
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return "$code: $message";
  }
}

/// Accounts

class AccountNameAlreadyExistsException extends AppException {
  AccountNameAlreadyExistsException()
      : super._(
          code: 'account_name_already_exists',
          message: 'An account with this name already exists.',
        );
}

class InvalidAccountNameException extends AppException {
  InvalidAccountNameException()
      : super._(
          code: 'invalid_account_name',
          message: 'Please enter a valid account name.',
        );
}

/// Expenses

class InvalidExpenseCategoryException extends AppException {
  InvalidExpenseCategoryException()
      : super._(
          code: 'invalid_expense_category',
          message: 'Please enter a valid expense category.',
        );
}

class InvalidExpenseAmountException extends AppException {
  InvalidExpenseAmountException()
      : super._(
          code: 'invalid_expense_amount',
          message: 'Please enter a valid expense amount.',
        );
}

/// Database

class DatabaseException extends AppException {
  DatabaseException(String message)
      : super._(
          code: 'database_error',
          message: message,
        );
}

class DatabaseCorruptionException extends AppException {
  DatabaseCorruptionException()
      : super._(
          code: 'database_corruption',
          message:
              'The local database appears to be corrupted. Please restart the app or reinstall.',
        );
}
