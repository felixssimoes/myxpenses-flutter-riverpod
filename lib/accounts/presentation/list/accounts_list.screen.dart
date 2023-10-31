import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/domain/account.model.dart';
import 'package:myxpenses/core/core.dart';

import '../../application/accounts.notifiers.dart';

class AccountsListScreen extends ConsumerWidget {
  const AccountsListScreen({super.key});

  static const addAccountKey = Key('add-account-button');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            key: addAccountKey,
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
                  return AccountListTile(
                    account: account,
                    onTap: () => ref
                        .read(appRouterProvider)
                        .openAccountDetails(account.id),
                  );
                },
              ),
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    required this.account,
    required this.onTap,
    super.key,
  });

  final AccountModel account;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(account.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
