import 'package:flutter/material.dart';

class AccountNameFormField extends StatelessWidget {
  const AccountNameFormField({
    required this.controller,
    this.enabled = true,
    this.accountId,
    super.key,
  });

  final TextEditingController controller;
  final String? accountId;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Account Name',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an account name';
        }
        return null;
      },
    );
  }
}
