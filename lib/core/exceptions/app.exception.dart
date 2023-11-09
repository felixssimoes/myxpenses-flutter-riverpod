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
