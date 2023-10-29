import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/core/core.dart';

import '../../application/accounts.notifiers.dart';

class AccountsListScreen extends ConsumerWidget {
  const AccountsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            onPressed: () => ref.read(appRouterProvider).openCreateAccount(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
      body: AsyncValueWidget(
        value: ref.watch(accountsProvider),
        data: (accounts) => accounts.isEmpty
            ? const Center(child: Text('no accounts created yet'))
            : ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return ListTile(title: Text(account.name));
                },
              ),
      ),
    );
  }
}
