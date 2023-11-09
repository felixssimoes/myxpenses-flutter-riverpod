import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';

class CreateExpenseScreen extends ConsumerWidget {
  const CreateExpenseScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountValue = ref.watch(accountProvider(accountId));
    return Scaffold(
      appBar: AppBar(title: const Text('New Expense')),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              width: double.infinity,
              height: 30,
              child: Center(
                child:
                    Text('Account: ${accountValue.valueOrNull?.name ?? '???'}'),
              )),
          Center(
            child: Text(accountId),
          ),
        ],
      ),
    );
  }
}
