import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';

class AccountNameFormField extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
        if (ref
            .read(accountsRepositoryProvider)
            .accounts
            .any((a) => a.name == value && a.id != accountId)) {
          return 'Account name already exists';
        }
        return null;
      },
    );
  }
}
