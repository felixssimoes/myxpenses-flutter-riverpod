import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myxpenses/accounts/accounts.dart';
import 'package:myxpenses/core/core.dart';

class AccountDetailsScreen extends ConsumerWidget {
  const AccountDetailsScreen({
    required this.accountId,
    super.key,
  });

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountValue = ref.watch(accountProvider(accountId));
    return Scaffold(
      appBar: AppBar(
        title: Text(accountValue.valueOrNull?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(appRouterProvider).openEditAccount(accountId),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
