import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';
import 'package:myxpenses/date_interval/date_interval.dart';

import 'widgets/accounts_list_tile.dart';

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
      body: Column(
        children: [
          const DateIntervalSelector(),
          Expanded(
            child: AsyncValueWidget(
              skipLoadingOnReload: true,
              value: ref.watch(accountsViewProvider),
              data: (accountViews) => accountViews.isEmpty
                  ? const Center(child: Text('no accounts created yet'))
                  : ListView.builder(
                      itemCount: accountViews.length,
                      itemBuilder: (context, index) {
                        final accountView = accountViews[index];
                        return AccountListTile(
                          account: accountView.account,
                          total: accountView.total,
                          onTap: () => ref
                              .read(appRouterProvider)
                              .openAccountDetails(accountView.account.id),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
