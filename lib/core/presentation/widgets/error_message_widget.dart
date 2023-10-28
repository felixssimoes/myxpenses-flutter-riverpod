import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    this.errorMessage,
    super.key,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage ?? 'Oops, something went wrong!',
      style: const TextStyle(color: Colors.red),
    );
  }
}
