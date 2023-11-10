import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseAmountFormField extends ConsumerWidget {
  const ExpenseAmountFormField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
          labelText: 'Amount', icon: Icon(Icons.attach_money)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        final parsedValue = double.tryParse(value);
        if (parsedValue == null || parsedValue <= 0) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }
}
